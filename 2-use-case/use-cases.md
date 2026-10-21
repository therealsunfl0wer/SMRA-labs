# Rent-a-Gig Use Cases

## Actor Catalog

### Primary Actors

1. **Musician**
   - Description: Individual user who plays instruments and seeks performance opportunities
   - Goals: Find compatible Bands, sign up for Events, manage profile
   - Characteristics: Registered user with musical skills
   - Relationships: Interacts with Band, Event, Instrument, Genre, Signup

2. **Band**
   - Description: Group of Musicians that publishes Events and Releases
   - Goals: Attract Musicians to Events, publish Releases, manage profile
   - Characteristics: Organizational entity with multiple members
   - Relationships: Interacts with Musician, Event, Release, Instrument, Genre

### Secondary Actors

1. **System Administrator**
   - Description: Manages platform configuration and resolves issues
   - Goals: Maintain system integrity, monitor performance
   - Characteristics: Technical staff with elevated privileges
   - Relationships: Interacts with all entities (out of scope for MVP)

## Use Case Catalog

### Band Use Cases

#### UC-BAND-001: Publish Event

- Primary Actor: Band
- Secondary Actors: None
- Preconditions: Band is registered and authenticated
- Main Success Scenario:
  1. Band selects "Create Event"
  2. System displays Event form
  3. Band enters Event details (name, info, location, date)
  4. Band submits form
  5. System validates data
  6. System creates Event with status "published"
  7. System notifies Band of success
- Postconditions: New Event exists in system
- Extensions:
  - 5a. Invalid data: System displays validation errors, return to step 2
  - 5b. Past date: System rejects with error, return to step 2

#### UC-BAND-002: Update Event

- Primary Actor: Band
- Preconditions: Event exists and belongs to Band
- Main Success Scenario:
  1. Band selects Event to update
  2. System displays Event edit form
  3. Band modifies Event details
  4. Band submits changes
  5. System validates and saves changes
- Postconditions: Event is updated
- Extensions:
  - 5a. Event has Signups: System prevents date changes that would invalidate existing Signups

#### UC-BAND-003: Delete Event

- Primary Actor: Band
- Preconditions: Event exists and belongs to Band
- Main Success Scenario:
  1. Band selects Event to delete
  2. System checks for existing Signups
  3. System deletes Event
- Postconditions: Event is removed
- Extensions:
  - 2a. Event has Signups: System prevents deletion, displays error

#### UC-BAND-004: Create Release

- Primary Actor: Band
- Preconditions: Band is registered
- Main Success Scenario:
  1. Band selects "Create Release"
  2. System displays Release form
  3. Band enters Release details (name, link, date, Genre)
  4. Band submits form
  5. System validates data (including URL format)
  6. System creates Release linked to Band and Genre
- Postconditions: New Release exists
- Extensions:
  - 5a. Invalid URL: System rejects with validation error

#### UC-BAND-005: Manage Band Instruments

- Primary Actor: Band
- Preconditions: Band is registered
- Main Success Scenario:
  1. Band selects "Manage Instruments"
  2. System displays current Instruments
  3. Band adds/removes Instruments
  4. System updates Band-Instrument associations
- Postconditions: Band's Instruments are updated

### Musician Use Cases

#### UC-MUS-001: Sign Up for Event

- Primary Actor: Musician
- Preconditions: Musician is registered, Event is published
- Main Success Scenario:
  1. Musician browses Events
  2. Musician selects an Event
  3. Musician clicks "Sign Up"
  4. Musician provides additional info
  5. System validates signup (no duplicate)
  6. System creates Signup
- Postconditions: Signup exists linking Musician to Event
- Extensions:
  - 5a. Musician already signed up: System prevents duplicate, displays message
  - 5b. Event at capacity: System rejects signup

#### UC-MUS-002: Browse Bands by Genre

- Primary Actor: Musician
- Preconditions: Bands and Genres exist
- Main Success Scenario:
  1. Musician selects "Browse Bands"
  2. Musician filters by Genre
  3. System returns Bands matching Genre
  4. Musician views Band details
- Postconditions: Musician discovers compatible Bands
- Extensions:
  - 3a. No Bands match: System returns empty list with message

#### UC-MUS-003: Browse Bands by Instrument

- Primary Actor: Musician
- Preconditions: Bands and Instruments exist
- Main Success Scenario:
  1. Musician selects "Browse Bands"
  2. Musician filters by Instrument
  3. System returns Bands utilizing Instrument
- Postconditions: Musician discovers Bands needing their skills

#### UC-MUS-004: Manage Musician Instruments

- Primary Actor: Musician
- Preconditions: Musician is registered
- Main Success Scenario:
  1. Musician selects "My Profile"
  2. Musician navigates to Instruments section
  3. Musician adds/removes Instruments
  4. System updates Musician-Instrument associations
- Postconditions: Musician's Instruments are updated

#### UC-MUS-005: View Event Details

- Primary Actor: Musician
- Preconditions: Event exists
- Main Success Scenario:
  1. Musician selects an Event
  2. System displays Event details (name, info, location, date, Band)
  3. System shows signup status (if Musician is signed up)
- Postconditions: Musician has Event information

## Use Case Relationships

- **UC-BAND-001** includes validation (shared with UC-BAND-004)
- **UC-MUS-001** extends **UC-MUS-005** (viewing details before signup)
- **UC-MUS-002** and **UC-MUS-003** share common Band browsing infrastructure
