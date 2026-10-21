# Rent-a-Gig Traceability Matrix

## Traceability Links

   **Requirement ID** | **Use Case** | **User Story** | **Scenario** | **Entity** | **EARS Type** | **Status** |
  ------------------- | -------------- | ---------------- | -------------- | ------------ | --------------- | ------------ |
  EARS-UB-001 | All | All | All | All | Ubiquitous | Implemented |
  EARS-UB-002 | All | All | All | All | Ubiquitous | Implemented |
  EARS-UB-003 | All | All | All | All | Ubiquitous | Implemented |
  EARS-EV-001 | UC-BAND-001 | US-1 | Band publishes Event | Event, Band | Event-driven | Implemented |
  EARS-EV-001 | UC-BAND-001 | US-1 | Band publishes Event with invalid date | Event, Band | Event-driven | Implemented |
  EARS-EV-004 | UC-MUS-001 | US-2 | Musician signs up for Event | Signup, Musician, Event | Event-driven | Implemented |
  EARS-EV-004 | UC-MUS-001 | US-2 | Musician tries duplicate signup | Signup, Musician, Event | Event-driven | Implemented |
  EARS-EV-006 | UC-BAND-004 | US-3 | Band creates Release | Release, Band, Genre | Event-driven | Implemented |
  EARS-EV-006 | UC-BAND-004 | US-3 | Band creates Release with invalid URL | Release, Band, Genre | Event-driven | Implemented |
  EARS-IF-001 | UC-MUS-001 | US-2 | Musician tries duplicate signup | Signup | Unwanted | Implemented |
  EARS-IF-002 | UC-MUS-001 | Edge case | Concurrent signups at capacity | Signup, Event | Unwanted | Implemented |
  EARS-IF-005 | UC-BAND-001 | Edge case | Band tries past date | Event | Unwanted | Implemented |
  EARS-ST-001 | UC-BAND-003 | Edge case | Band tries delete Event with Signups | Event, Signup | State-driven | Implemented |
  EARS-ST-003 | N/A | N/A | Genre deletion prevented | Genre, Release | State-driven | Implemented |
  EARS-OP-001 | UC-MUS-003 | US-4 | Musician browses Bands by Genre | Band, Genre, Musician | Optional | Implemented |
  EARS-OP-002 | UC-BAND-005 | US-5 | Band manages Instruments | Band, Instrument | Optional | Implemented |
  EARS-OP-003 | UC-MUS-004 | US-6 | Musician manages Instruments | Musician, Instrument | Optional | Implemented |
  FR-001 | UC-BAND-001, UC-BAND-002, UC-BAND-003 | US-1 | All Event operations | Event | Functional | Implemented |
  FR-002 | UC-MUS-001 | US-2 | Signup creation | Signup | Functional | Implemented |
  FR-003 | UC-MUS-001 | US-2 | Prevent duplicate Signups | Signup | Functional | Implemented |
  FR-004 | UC-BAND-004 | US-3 | Release creation | Release | Functional | Implemented |
  FR-005 | UC-MUS-002, UC-MUS-003 | US-4, US-5 | Band filtering | Band, Genre, Instrument | Functional | Implemented |
  FR-006 | All | All | All | All | Functional | Implemented |
  FR-007 | All | All | All | All | Functional | Implemented |
  SC-001 | UC-BAND-001 | US-1 | Band publishes Event | Event | Success | Measurable |
  SC-002 | UC-MUS-001 | US-2 | Musician signs up | Signup | Success | Measurable |
  SC-003 | UC-MUS-002, UC-MUS-003 | US-4 | Band discovery | Band | Success | Measurable |

## Many-to-Many Traceability

### Requirements → Use Cases

- **EARS-EV-001** traces to: UC-BAND-001, UC-BAND-002, UC-BAND-003
- **EARS-EV-004** traces to: UC-MUS-001
- **EARS-IF-001** traces to: UC-MUS-001
- **EARS-ST-001** traces to: UC-BAND-003
- **FR-001** traces to: UC-BAND-001, UC-BAND-002, UC-BAND-003
- **FR-005** traces to: UC-MUS-002, UC-MUS-003

### Use Cases → Scenarios

- **UC-BAND-001** traces to: 2 Gherkin scenarios
- **UC-MUS-001** traces to: 4 Gherkin scenarios (including edge cases)
- **UC-BAND-004** traces to: 2 Gherkin scenarios
- **UC-MUS-002** traces to: 2 Gherkin scenarios

### Entities → Use Cases

- **Event** appears in: UC-BAND-001, UC-BAND-002, UC-BAND-003, UC-MUS-001, UC-MUS-005
- **Band** appears in: All Band use cases + Musician browsing use cases
- **Musician** appears in: All Musician use cases
- **Signup** appears in: UC-MUS-001, UC-BAND-003 (deletion prevention)
- **Release** appears in: UC-BAND-004, Genre deletion prevention
- **Genre** appears in: UC-BAND-004, UC-MUS-002, Genre deletion prevention
- **Instrument** appears in: UC-BAND-005, UC-MUS-003, UC-MUS-004

### User Stories → All Artifacts

- **US-1 (P1)** traces to: UC-BAND-001, EARS-EV-001, 2 scenarios, Event/Band entities
- **US-2 (P1)** traces to: UC-MUS-001, EARS-EV-004/EARS-IF-001, 4 scenarios, Signup/Musician/Event entities
- **US-3 (P2)** traces to: UC-BAND-004, EARS-EV-006/EARS-IF-006, 2 scenarios, Release/Band/Genre entities
- **US-4 (P2)** traces to: UC-MUS-002, EARS-OP-001, 2 scenarios, Band/Genre/Musician entities
- **US-5 (P3)** traces to: UC-BAND-005, EARS-OP-002, 1 scenario, Band/Instrument entities
- **US-6 (P3)** traces to: UC-MUS-004, EARS-OP-003, 1 scenario, Musician/Instrument entities

## Uncovered Requirements

  **Requirement ID** | **Description** | **Reason Not Covered** | **Impact** |
  ------------------- | ---------------- | ------------------------ | ------------ |
  **EARS-NF-001** | System response time <500ms | Performance testing not in scope for functional specs | Low - Non-functional, requires load testing |
  **EARS-NF-002** | Concurrent operations without corruption | Implicit in edge case scenarios but not explicitly tested | Medium - Needs dedicated concurrency tests |
  **EARS-NF-003** | Input validation against injection | Security requirement, out of scope for behavior specs | Medium - Security testing separate |
  **FR-007** | Referential integrity maintenance | Implicit in state-driven requirements but not all relationships tested | Medium - Needs comprehensive integrity tests |

**Note**: EARS-NF-001 is not covered by any use case or scenario because it's a non-functional requirement requiring performance testing infrastructure. The functional specifications focus on behavior rather than performance characteristics.
