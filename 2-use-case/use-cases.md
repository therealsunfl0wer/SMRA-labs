# Rent-a-Gig Use Cases

## Actor Catalog

### Primary Actors

1. **Musician**
   - Description: Individual user who plays instruments and seeks performance opportunities
   - Goals: Create profile, find Bands, sign up for Events, manage personal data
   - Characteristics: Registered user with musical skills
   - Relationships: Generalized by Band Member

2. **Band Member**
   - Description: Musician who is part of a Band and can perform Band-level actions
   - Goals: Create and manage Bands, publish Events and Releases, invite other Musicians
   - Characteristics: Musician with Band affiliation
   - Relationships: Specialization of Musician (Band Member **is a** Musician)

### External Systems

1. **Email Service**
   - Description: External system for sending email notifications
   - Goals: Deliver notifications to Musicians and Band Members
   - Characteristics: Third-party service
   - Relationships: Used by Send Email Notification use case

2. **Streaming Platform**
   - Description: External platform for hosting music releases
   - Goals: Validate and host Release links
   - Characteristics: Third-party service
   - Relationships: Used by Validate Release Link use case

## Use Case Catalog

### Musician Use Cases

**UC-MUS-001: Create Musician Profile**

- Primary Actor: Musician
- Preconditions: User is not registered
- Main Success Scenario:
  1. Musician selects "Create Profile"
  2. System displays profile form
  3. Musician enters name, bio, email
  4. Musician submits form
  5. System validates data and creates Musician profile
- Postconditions: New Musician exists in system
- Extensions:
  - 5a. Invalid email: System rejects with validation error

**UC-MUS-002: Edit Musician Profile**

- Primary Actor: Musician
- Preconditions: Musician is registered and authenticated
- Main Success Scenario:
  1. Musician selects "Edit Profile"
  2. System displays edit form with current data
  3. Musician modifies profile details
  4. Musician submits changes
  5. System validates and saves changes
- Postconditions: Musician profile is updated

**UC-MUS-003: Search Bands**

- Primary Actor: Musician
- Preconditions: Bands exist in system
- Main Success Scenario:
  1. Musician selects "Search Bands"
  2. System displays search interface
  3. Musician submits search query
  4. System returns matching Bands
- Postconditions: Musician views Band list

**UC-MUS-004: Filter Bands by Genre**

- Primary Actor: Musician
- Preconditions: Bands and Genres exist
- Main Success Scenario:
  1. Musician selects Genre filter
  2. System filters Bands by selected Genre
- Postconditions: Musician views filtered Band list
- Relationships: **is a** specialization of UC-MUS-003 (Search Bands)

**UC-MUS-005: Filter Bands by Instrument**

- Primary Actor: Musician
- Preconditions: Bands and Instruments exist
- Main Success Scenario:
  1. Musician selects Instrument filter
  2. System filters Bands by selected Instrument
- Postconditions: Musician views filtered Band list
- Relationships: **is a** specialization of UC-MUS-003 (Search Bands)

**UC-MUS-006: View Band Profile**

- Primary Actor: Musician
- Preconditions: Band exists
- Main Success Scenario:
  1. Musician selects a Band
  2. System displays Band profile (name, info, Genres, Instruments, Releases)
- Postconditions: Musician views Band details

**UC-MUS-007: View Event Details**

- Primary Actor: Musician
- Preconditions: Event exists
- Main Success Scenario:
  1. Musician selects an Event
  2. System displays Event details (name, info, location, date, Band)
- Postconditions: Musician has Event information

**UC-MUS-008: Sign Up for Event**

- Primary Actor: Musician
- Preconditions: Musician is registered, Event is published
- Main Success Scenario:
  1. Musician views Event details (UC-MUS-007)
  2. Musician clicks "Sign Up"
  3. System creates Signup record
- Postconditions: Signup exists linking Musician to Event
- Relationships: **extends** UC-MUS-007 (View Event Details)
- Extensions:
  - 2a. Musician already signed up: System prevents duplicate
  - 2b. Event at capacity: System rejects signup

**UC-MUS-009: Write Signup Note**

- Primary Actor: Musician
- Preconditions: Musician has signed up for Event
- Main Success Scenario:
  1. Musician edits Signup
  2. Musician adds note in info field
  3. System saves note
- Postconditions: Signup info is updated
- Relationships: **extends** UC-MUS-008 (Sign Up for Event) if note entered

**UC-MUS-010: Cancel Signup**

- Primary Actor: Musician
- Preconditions: Musician has active Signup
- Main Success Scenario:
  1. Musician selects Signup to cancel
  2. System removes Signup
- Postconditions: Signup is deleted

**UC-MUS-011: View Contact Info**

- Primary Actor: Musician
- Preconditions: Signup exists for Musician
- Main Success Scenario:
  1. Musician selects Signup
  2. System displays additional contact information
- Postconditions: Musician views contact details

### Band Member Use Cases

**UC-BM-001: Create Band**

- Primary Actor: Band Member
- Preconditions: Band Member is registered Musician
- Main Success Scenario:
  1. Band Member selects "Create Band"
  2. System displays Band form
  3. Band Member enters Band details (name, email, info)
  4. Band Member submits form
  5. System validates and creates Band
- Postconditions: New Band exists, Band Member is associated

**UC-BM-002: Edit Band Profile**

- Primary Actor: Band Member
- Preconditions: Band exists and Band Member belongs to it
- Main Success Scenario:
  1. Band Member selects Band to edit
  2. System displays edit form
  3. Band Member modifies Band details
  4. Band Member submits changes
  5. System validates and saves changes
- Postconditions: Band profile is updated
- Relationships: **includes** UC-SYS-001 (Validate Input)

**UC-BM-003: Invite Musician to Band**

- Primary Actor: Band Member
- Preconditions: Band exists, Band Member belongs to Band, Musician exists
- Main Success Scenario:
  1. Band Member selects "Invite Musician"
  2. Band Member selects Musician to invite
  3. System sends invitation
  4. Musician accepts invitation
  5. System associates Musician with Band
- Postconditions: Musician is Band Member
- Relationships: **includes** UC-SYS-001 (Validate Input), **includes** UC-SYS-003 (Send Email Notification)

**UC-BM-004: Leave Band**

- Primary Actor: Band Member
- Preconditions: Band Member belongs to Band
- Main Success Scenario:
  1. Band Member selects "Leave Band"
  2. System removes association
- Postconditions: Band Member is no longer in Band

**UC-BM-005: Publish Event**

- Primary Actor: Band Member
- Preconditions: Band exists, Band Member belongs to Band
- Main Success Scenario:
  1. Band Member selects "Publish Event"
  2. System displays Event form
  3. Band Member enters Event details (name, info, location, date)
  4. Band Member submits form
  5. System validates and creates Event
- Postconditions: New Event exists linked to Band
- Relationships: **includes** UC-SYS-001 (Validate Input)

**UC-BM-006: Cancel Event**

- Primary Actor: Band Member
- Preconditions: Event exists, Band Member belongs to Event's Band, no Signups exist
- Main Success Scenario:
  1. Band Member selects Event to cancel
  2. System deletes Event
- Postconditions: Event is removed
- Relationships: **includes** UC-SYS-001 (Validate Input), **includes** UC-SYS-003 (Send Email Notification)

**UC-BM-007: Review Event Signups**

- Primary Actor: Band Member
- Preconditions: Event exists, Band Member belongs to Event's Band
- Main Success Scenario:
  1. Band Member selects Event
  2. System displays list of Signups
- Postconditions: Band Member views Signups
- Relationships: **includes** UC-SYS-001 (Validate Input)

**UC-BM-008: Publish Release**

- Primary Actor: Band Member
- Preconditions: Band exists, Band Member belongs to Band
- Main Success Scenario:
  1. Band Member selects "Publish Release"
  2. System displays Release form
  3. Band Member enters Release details (name, link, date, Genre)
  4. Band Member submits form
  5. System validates and creates Release
- Postconditions: New Release exists linked to Band and Genre
- Relationships: **includes** UC-SYS-001 (Validate Input), **includes** UC-SYS-002 (Validate Release Link), **includes** UC-SYS-003 (Send Email Notification)

### System Use Cases

**UC-SYS-001: Validate Input**

- Primary Actor: System
- Description: Validates all user input against defined rules (data types, formats, constraints)
- Preconditions: User input received
- Main Success Scenario:
  1. System receives input data
  2. System checks against validation rules
  3. System returns validation result
- Postconditions: Input is validated or errors are returned

**UC-SYS-002: Validate Release Link**

- Primary Actor: System
- Description: Validates that Release link is a valid URL and accessible
- Preconditions: Release link provided
- Main Success Scenario:
  1. System receives URL
  2. System validates URL format
  3. System checks URL accessibility (optional)
- Postconditions: Link is validated or error is returned
- Relationships: Interacts with Streaming Platform

**UC-SYS-003: Send Email Notification**

- Primary Actor: System
- Description: Sends email notifications to Musicians and Band Members
- Preconditions: Notification event triggered
- Main Success Scenario:
  1. System prepares notification
  2. System sends to Email Service
  3. Email Service delivers email
- Postconditions: Notification sent
- Relationships: Interacts with Email Service
