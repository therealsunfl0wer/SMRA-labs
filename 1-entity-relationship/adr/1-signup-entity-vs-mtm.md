# Model sign-ups as a separate Signup entity

## Status
Accepted

## Context and problem statement
A musician can sign up for many events, and an event has many musicians. The specification also says that each `Signup` belongs to exactly one musician and exactly one event, and that a musician may sign up for an event at most once. Should this relationship be represented directly as many-to-many, or as an associative entity?

## Decision drivers
- The relationship between `Musician` and `Event` has its own attribute, `info`, which belongs to the `Signup` rather than to either entity.
- The specification permits associative entities only when the relationship has its own attributes.
- Every entity must have a primary key, and the current model consistently uses a single-column `int id` primary key.
- The relationship must preserve the rule that a musician can have at most one sign-up per event.

## Considered options
- Direct many-to-many relationship between `Musician` and `Event`.
- `Signup` entity with its own `id` (chosen).
- `Signup` entity with a composite primary key (`event_id`, `musician_id`).

## Decision outcome
Chosen: represent the sign-up as a separate `Signup` entity with its own `int id` primary key.

A sign-up is a meaningful association between one musician and one event, and it has its own `info` attribute. Giving it an entity also fits the specification's convention that every entity has a primary key and keeps the model consistent with the other entities' single-column identifiers.

The `Signup` entity must be related to both `Musician` and `Event`. Its foreign keys should identify those entities and use the same types as the referenced primary keys. In particular, the `band_email` attribute did not represent the specified `Musician <--> Signup` relationship, which was replaced with `musician_id int (FK)`.

## Consequences
- Good: `info` just fits on `Signup` since that's where we can share the contact info, this relationship is explicit and all entities can use the same single-column primary-key convention.
- Good: `Signup` can be referenced as an entity if the domain later needs to refer to an individual sign-up.
- Bad: the model contains one more entity than a direct many-to-many relationship would.
- Bad: the surrogate key does not, by itself, prevent duplicate sign-ups, so the uniqueness rule needs a separate constraint.

## Pros and cons of the options

### Direct many-to-many
- Good: fewer modeled entities and a compact conceptual relationship.
- Bad: it provides no clear place for the relationship's own `info` attribute under the specification's rule for associative entities.
- Bad: it does not express a sign-up as a separately identified record.

### Signup with its own id
- Bad: adds an entity and a primary key that aren't sufficient to prevent the same musician signing up for the same event twice.
- Good: provides a natural place for `info`, follows the single-column `id` convention used by the other entities, and gives each sign-up its own identifier.

### Signup with a composite key
- Good: (`event_id`, `musician_id`) naturally represents the pair and can enforce at most one sign-up per musician per event when used as the primary key.
- Bad: it departs from the model's convention of a single-column `id` primary key and makes the identifier composite.
- Bad: the relationship's `info` attribute still requires an associative entity, so this option does not eliminate the entity itself.
