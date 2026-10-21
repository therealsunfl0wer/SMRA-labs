# Rent-a-Gig Requirements (EARS)

## Ubiquitous Requirements

1. **EARS-UB-001**: The system shall store all entities with their defined primary keys.
2. **EARS-UB-002**: The system shall enforce foreign key constraints for all relationships.
3. **EARS-UB-003**: The system shall maintain data in 4NF normalization.
4. **EARS-UB-004**: All entity names shall follow PascalCase convention.
5. **EARS-UB-005**: All attribute names shall follow snake_case convention.
6. **EARS-UB-006**: The system shall use integer types for all primary and foreign keys.

## Event-Driven Requirements

### Band Operations

1. **EARS-EV-001**: When a Band submits valid Event details, the system shall create the Event with status "published".
2. **EARS-EV-002**: When a Band updates an Event, the system shall validate changes and persist the updated Event.
3. **EARS-EV-003**: When a Band deletes an Event, the system shall remove the Event if no Signups exist.

### Musician Operations

 1. **EARS-EV-004**: When a Musician submits valid signup for an Event, the system shall create a Signup record.
 2. **EARS-EV-005**: When a Musician updates their profile, the system shall validate and persist changes.

### Release Operations

 1. **EARS-EV-006**: When a Band submits valid Release details, the system shall create the Release linked to the Band and Genre.
 2. **EARS-EV-007**: When a Band deletes a Release, the system shall remove it if no dependencies exist.

## State-Driven Requirements

 1. **EARS-ST-001**: While an Event has active Signups, the system shall prevent Event deletion.
 2. **EARS-ST-002**: While a Musician has active Signups, the system shall prevent Musician deletion.
 3. **EARS-ST-003**: While a Genre has linked Releases, Bands, or Musicians, the system shall prevent Genre deletion.
 4. **EARS-ST-004**: While a Band has published Events or Releases, the system shall prevent Band deletion.

## Unwanted Behavior Requirements

 1. **EARS-IF-001**: If a Musician attempts to sign up for the same Event twice, then the system shall reject the duplicate signup.
 2. **EARS-IF-002**: If an Event reaches capacity, then the system shall reject subsequent signup attempts.
 3. **EARS-IF-003**: If invalid data is submitted for any entity, then the system shall return specific validation errors.
 4. **EARS-IF-004**: If a foreign key reference is invalid, then the system shall reject the operation with integrity error.
 5. **EARS-IF-005**: If a Band attempts to create an Event with a past date, then the system shall reject with date validation error.
 6. **EARS-IF-006**: If a Release link is not a valid URL, then the system shall reject the Release creation.

## Optional Requirements

 1. **EARS-OP-001**: Where a Musician specifies Instruments, the system shall enable instrument-based Band filtering.
 2. **EARS-OP-002**: Where a Band specifies Instruments, the system shall enable instrument-based Musician matching.
 3. **EARS-OP-003**: Where a Musician specifies Genres, the system shall enable genre-based Band discovery.

## Non-Functional Requirements

 1. **EARS-NF-001**: The system shall respond to all API requests within 500ms under normal load.
 2. **EARS-NF-002**: The system shall support concurrent operations without data corruption.
 3. **EARS-NF-003**: The system shall validate all inputs against injection attacks.
