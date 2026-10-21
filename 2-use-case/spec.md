# Rent-a-Gig Platform Specification

**Feature Branch**: `2-use-case`
**Created**: 2026-10-21

## User Scenarios & Testing

### User Story 1 - Band Publishes Event (Priority: P1)

A Band can create and publish Events with details (name, info, location, date). Musicians can discover these events.

**Why this priority**: Core functionality enabling the platform's value proposition - connecting musicians with performance opportunities.

**Independent Test**: Can be tested by creating a Band, publishing an Event, and verifying it appears in the event list.

**Acceptance Scenarios**:

1. **Given** a registered Band, **When** they submit valid event details, **Then** the Event is created with status "published"
2. **Given** a Band with incomplete profile, **When** they try to publish an Event, **Then** the system rejects with validation error

---

### User Story 2 - Musician Signs Up for Event (Priority: P1)

A Musician can sign up for any published Event, creating a Signup record with additional info.

**Why this priority**: Essential for musician engagement and the platform's matchmaking functionality.

**Independent Test**: Can be tested by having a Musician sign up for an Event and verifying the Signup is recorded.

**Acceptance Scenarios**:

1. **Given** a published Event, **When** a Musician submits signup, **Then** a Signup record is created linking Musician to Event
2. **Given** an Event at capacity, **When** a Musician tries to sign up, **Then** the system rejects with "Event full" message

---

### User Story 3 - Band Manages Releases (Priority: P2)

A Band can create Releases (albums, EPs, singles) associated with their profile and a Genre.

**Why this priority**: Enables bands to showcase their work, helping musicians discover compatible groups.

**Independent Test**: Can be tested by creating a Release and verifying it appears on the Band's profile.

**Acceptance Scenarios**:

1. **Given** a Band with profile, **When** they create a Release with valid details, **Then** the Release is published and linked to Band
2. **Given** invalid release link, **When** Band submits, **Then** system rejects with URL validation error

---

### User Story 4 - Musician Browses Bands by Genre (Priority: P2)

Musicians can filter Bands by Genre to find compatible groups.

**Why this priority**: Critical discovery mechanism for musicians to find bands matching their style.

**Independent Test**: Can be tested by searching for Bands with a specific Genre and verifying correct results.

**Acceptance Scenarios**:

1. **Given** Bands with various Genres, **When** Musician filters by "Rock", **Then** only Bands with Rock Genre are returned
2. **Given** no Bands match filter, **When** Musician searches, **Then** system returns empty list with "No results" message

---

### User Story 5 - Band Manages Instruments (Priority: P3)

A Band can specify which Instruments they utilize, helping musicians find compatible groups.

**Why this priority**: Enhances matching accuracy but not essential for MVP.

**Independent Test**: Can be tested by adding Instruments to a Band and verifying they appear on the profile.

**Acceptance Scenarios**:

1. **Given** a Band, **When** they add Instruments, **Then** the Instruments are associated with the Band
2. **Given** duplicate Instrument, **When** Band adds, **Then** system ignores duplicate (idempotent)

---

### User Story 6 - Musician Manages Profile Instruments (Priority: P3)

A Musician can specify which Instruments they play.

**Why this priority**: Enables better matching but can be added post-MVP.

**Independent Test**: Can be tested by adding Instruments to a Musician profile.

**Acceptance Scenarios**:

1. **Given** a Musician, **When** they add Instruments, **Then** the Instruments are associated with their profile

---

## Edge Cases

- What happens when a Musician tries to sign up for the same Event twice? → System prevents duplicate Signups per Musician-Event pair
- How does system handle concurrent Event signups exceeding capacity? → Last valid signup before capacity is accepted, subsequent ones rejected
- What if a Band tries to delete an Event with active Signups? → System prevents deletion and returns conflict error
- How does system handle invalid date formats for Events? → Rejects with specific validation error
- What happens when a Genre is deleted but Releases reference it? → System prevents Genre deletion (referential integrity)
- How does system handle Musician email changes? → Validates uniqueness and updates all related records

## Requirements

### Functional Requirements

- **FR-001**: System MUST allow Bands to create, read, update, delete Events
- **FR-002**: System MUST allow Musicians to create Signups for published Events
- **FR-003**: System MUST prevent duplicate Signups (one Musician per Event)
- **FR-004**: System MUST allow Bands to create Releases linked to Genres
- **FR-005**: System MUST allow filtering Bands by Genre and Instruments
- **FR-006**: System MUST validate all entity attributes according to data model
- **FR-007**: System MUST maintain referential integrity across all relationships

### Key Entities

- **Musician**: User who can join Bands and sign up for Events
- **Band**: Group that publishes Events and Releases
- **Event**: Performance opportunity published by a Band
- **Signup**: Musician's registration for an Event
- **Release**: Music publication by a Band (album, EP, single)
- **Genre**: Music category for Bands, Musicians, and Releases
- **Instrument**: Music instrument played by Musicians or utilized by Bands

## Success Criteria

### Measurable Outcomes

- **SC-001**: Bands can publish an Event in under 2 minutes
- **SC-002**: Musicians can sign up for an Event in under 1 minute
- **SC-003**: 95% of search queries return relevant results within 2 seconds
- **SC-004**: System handles 100 concurrent Event signups without data corruption

## Assumptions

- Musicians and Bands register before using platform features
- All dates use ISO 8601 format (YYYY-MM-DD)
- Event capacity limits are managed externally (not in data model)
- Email addresses are unique per Musician and per Band
- Validation occurs at API layer before database persistence
