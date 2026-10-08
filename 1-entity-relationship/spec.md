# Rent-a-Gig
## Domain
**Rent-a-Gig** is a platform where musicians create profiles, form bands, and bands publish events they participate in. Musicians can browse bands by their attributes (genre, discography) and sign up for events to perform with the band.

## Entities and attributes
### Musician
The core user role, can join bands or sign up for an event.
- `int id` (PK) 
- `string name`
- `string bio`
- `string email`

### Band
#### A group musicians can be part of that can publish events or releases.
- `int id` (PK)
- `string name`
- `string email`
- `string info`

### Event
#### An event a band can publish and a musician can sign up to.
- `int id` (PK)
- `int band_id` (FK)
- `string name`
- `string info`
- `string location`
- `date date`

### Instrument
- `int id` (PK)
- `string name`

### Signup
#### Musicians sign up to en event which allows them to access additional contact information.
- `int id` (PK)
- `int event_id` (FK)
- `string band_email` (FK)
- `string info`

### Release
#### An album, EP or a single released by a band.
- `int id` (PK)
- `int band_id` (FK)
- `string name`
- `string link`
- `date date`

### Genre
#### A genre musicians or bands prefer and releases have.
- `int id` (PK)
- `string name`

## Relationships
#### Musician <--> Band
A Musician belongs to zero, one, or many Bands and a Band consists of one or many Musicians.

#### Musician <--> Instrument
A Musician plays one or many Instruments and an Instrument is played by zero, one, or many Musicians.

#### Musician <--> Signup
A Musician creates zero, one, or many Signups (at most one per Event) and a Signup is associated with one and only one Musician.

#### Musician <--> Genre
A Musician performs one or many Genres and a Genre features one or many Musicians.

#### Band <--> Event
A Band hosts zero, one, or many Events and an Event is published by one and only one Band.

### Band <--> Instrument
A Band utilizes one or many Instruments and an Instrument is utilized by zero, one, or many Bands.

#### Band <--> Release
A Band owns zero, one, or many Releases and a Release is issued by one and only one Band.

#### Band <--> Genre
A Band represents one or many Genres and a Genre encompasses one or many Bands.

#### Event <--> Signup
An Event contains one or many Signups and a Signup targets one and only one Event.

#### Release <--> Genre
A Release belongs to one and only one Genre and a Genre classifies one or many Releases.

### Assumptions (out of scope)
- Venues are only described in text and aren't a separate entity
- Negotiation, communication and payment take place outside of the project

## Acceptance criteria
- Every entity must have a relationship
- Every entity must have a unique identifier within its entity, which must be a primary key
- Every entity and attribute follows a naming convention, `PascalCase` for entities, `snake_case` for attributes
- Every relationship describes min/max values on both ends of it
- Foreign keys must have the same type as the primary key they reference
- Foreign keys appear only in one-to-many relationships, only on the "many" side
- Associative entities are allowed only if the relationship has its own attributes
- The spec must conform to 4NF of DBMS
- ER Diagram:
  - must contain every entity, relationship, attribute, its type and PK/FK mark from specs 
  - must draw each relationship between the same two entities, with the same min/max on both ends, as in the spec 
  - must follow naming conventions present in the specs
  - must NOT have extra items absent in specs