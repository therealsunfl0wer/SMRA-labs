# Store the signup limit as Event.capacity

## Status
Accepted

## Context and problem statement
Scenario 11 of `scenarios.feature`, EARS-IF-002, extension 2b of UC-MUS-001 and user story 2 all reject a signup when an Event "reaches capacity". The ER model had no capacity attribute, and the Task 2 `spec.md` assumed that "Event capacity limits are managed externally (not in data model)". The first draft of the sequence diagrams therefore needed a `CapacityProvider` participant that has no counterpart in the ER model. Where should the signup limit live?

## Decision drivers
- Sequence diagram participants must correspond to ER entities, or to layers that hold no domain data of their own.
- A participant that holds data and has a direct relationship with an entity is a candidate for the ER model, not for an external service.
- Scenario 11 has to be decidable with the data the model stores.
- Foreign keys, naming conventions and 4NF from the Task 1 acceptance criteria must still hold.

## Considered options
- Keep the limit external and read it from a `CapacityProvider` service.
- Add `int capacity` to `Event` (chosen).
- Add a separate `EventCapacity` entity related one-to-one to `Event`.

## Decision outcome
Chosen: add `int capacity` to `Event`.

The limit is a fact about exactly one Event and depends only on `Event.id`, so it is a plain attribute of `Event`. The count of Signups for the Event is derived from existing `Signup` rows and is not stored. The `CapacityProvider` participant is removed from the sequence diagrams, and the capacity is read together with the Event by `EventRepository.findById`.

## Consequences
- Good: scenario 11 and EARS-IF-002 become decidable inside the model, and no participant is left without an ER counterpart.
- Good: the 4NF criterion still holds because `capacity` depends only on the key of `Event`.
- Good: no new entity, relationship or foreign key.
- Bad: every Event must be published with a capacity, so Gherkin scenario 1 and UC-BM-005 gain a `capacity` input.
- Bad: the model does not say what happens when `capacity` is lowered below the current number of Signups; this is not covered by any use case yet.
- Bad: the Task 2 assumption "capacity is managed externally" is no longer valid and is replaced in `2-use-case/spec.md`.

## Pros and cons of the options

### External CapacityProvider
- Good: no change to the already submitted data model.
- Bad: introduces a participant that holds data directly related to Event but is not in the ER model.
- Bad: scenario 11 cannot be verified against the data model.

### Event.capacity
- Good: smallest change that removes the gap.
- Bad: edits an already submitted artifact.

### Separate EventCapacity entity
- Good: allows capacity to get its own attributes later.
- Bad: violates the rule that associative or extra entities need their own attributes, because the entity would only carry one value.
