# Rent-a-Gig Audit Report

## 1. EARS Notation Ambiguity Check

### Weak Formulations Found

   **Requirement ID** | **Issue** | **Problem** | **Fix Applied** |
 | ------------------- | ----------- | ------------- | ----------------- |
 | EARS-IF-002 | "Event reaches capacity" | "capacity" attribute is not defined in the data model (Event has no capacity field) | Add `capacity: int` to Event entity or remove the requirement |
 | EARS-ST-002 | "active Signups" | "active" status is not an attribute of Signup entity (Signup has: id, event_id, musician_id, info) | Add `status: string` to Signup entity or remove "active" qualifier |
 | EARS-OP-002 | "instrument-based Musician matching" | "matching" mechanism is undefined (no algorithm or criteria specified) | Define matching rules (e.g., exact instrument match, partial match) |

### Strong Requirements

All other 26 EARS requirements use precise EARS templates:

- **Ubiquitous**: 6 requirements — all clear and testable
- **Event-driven**: 4 of 7 clear (EARS-EV-002, EARS-EV-005, EARS-EV-007 are unambiguous but lack implementation)
- **State-driven**: 2 of 4 clear (EARS-ST-002, EARS-ST-004 have undefined terms)
- **Unwanted**: 6 requirements — all clear
- **Optional**: 2 of 3 clear (EARS-OP-002 has undefined mechanism)
- **Non-functional**: 3 requirements — all clear

---

## 2. Include/Extend/Generalization Check

### Actor Generalization

- **Band Member → Musician**: Correctly implemented as **"is a"** in use-cases.md and diagram
- **Verification**: Band Member inherits all Musician capabilities and adds Band-specific actions (create Band, publish Event, etc.)

### Use Case Generalization

- **UC-MUS-006 (Filter Bands by Genre) → UC-MUS-004 (Search Bands)**: Correctly implemented as **"is a"** in diagram
- **UC-MUS-007 (Filter Bands by Instrument) → UC-MUS-004 (Search Bands)**: Correctly implemented as **"is a"** in diagram

### Include Relationships

All documented include relationships are valid and bidirectional:

- **Validation**: UC-SYS-001 (Validate Input) included in all UC that modify data
- **Membership**: UC-SYS-004 (Verify Band Membership) included in all Band Member UC
- **Notification**: UC-SYS-003 (Send Email Notification) included where external communication is needed
- **Link Validation**: UC-SYS-002 (Validate Release Link) included in Release-related UC

### Extend Relationships

All extend relationships are valid:

- **UC-MUS-001 (Sign Up for Event) extends UC-MUS-005 (View Event Details)**: Correct direction — signup requires viewing details first
- **UC-MUS-009 (Write Signup Note) extends UC-MUS-001 (Sign Up for Event)**: Correct — note is optional extension of signup

---

## 3. Actor and Entity Verification Against Task 1 Model

### Data Model from spec.md

**Entities and Attributes:**

- **Musician**: id (PK), name, bio, email
- **Band**: id (PK), name, email, info
- **Event**: id (PK), band_id (FK), name, info, location, date
- **Instrument**: id (PK), name
- **Signup**: id (PK), event_id (FK), musician_id (FK), info
- **Release**: id (PK), band_id (FK), genre_id (FK), name, link, date
- **Genre**: id (PK), name

**Relationships:**

- Musician ↔ Band: M:N
- Musician ↔ Instrument: M:N
- Musician ↔ Signup: 1:N
- Musician ↔ Genre: M:N
- Band ↔ Event: 1:N
- Band ↔ Instrument: M:N
- Band ↔ Release: 1:N
- Band ↔ Genre: M:N
- Event ↔ Signup: 1:N
- Release ↔ Genre: N:1

### Verification Results

**Actors:**

 | **Actor** | **Type** | **Model Match** | **Attributes Coverage** |
 | ----------- | ---------- | ----------------- | ------------------------- |
 | Musician | Primary | ✅ Matches Musician entity | All attributes used implicitly in UC-MUS-001–011 |
 | Band Member | Primary | ✅ Specialization of Musician entity | Inherits Musician attributes, no additional attributes |
 | Email Service | External | ✅ External system (not in data model) | N/A |
 | Streaming Platform | External | ✅ External system (not in data model) | N/A |

**Entities:**

 | **Entity** | **Model Attributes** | **Use Cases Coverage** | **Scenarios Coverage** |
 | ------------ | ---------------------- | ------------------------ | ------------------------- |
 | Musician | id, name, bio, email | UC-MUS-001–011, UC-BM-001–008 | Scenarios 3,4,7,8,9,10,11 |
 | Band | id, name, email, info | UC-BM-001–008, UC-MUS-006, UC-MUS-008 | Scenarios 1,2,5,6,9,12,13 |
 | Event | id, band_id, name, info, location, date | UC-BM-005, UC-BM-006, UC-BM-007, UC-MUS-001, UC-MUS-005, UC-MUS-007 | Scenarios 1,2,3,4,11,12 |
 | Instrument | id, name | UC-MUS-007, UC-MUS-009, UC-BM-002, UC-BM-008 | Scenarios 9,10 |
 | Signup | id, event_id, musician_id, info | UC-MUS-001, UC-MUS-009, UC-MUS-010, UC-MUS-011, UC-BM-007 | Scenarios 3,4,11,12 |
 | Release | id, band_id, genre_id, name, link, date | UC-BM-008, UC-MUS-008 | Scenarios 5,6,13 |
 | Genre | id, name | UC-MUS-006, UC-BM-008 | Scenarios 7,8,13 |

**Relationships:**

 | **Relationship** | **Model** | **Use Cases** | **Scenarios** |
 | ------------------ | ----------- | --------------- | --------------- |
 | Musician ↔ Band | M:N | UC-BM-003 (Invite), UC-BM-004 (Leave) | None |
 | Musician ↔ Instrument | M:N | UC-MUS-007 (Filter), UC-MUS-009 (Write Note) | Scenario 10 |
 | Musician ↔ Signup | 1:N | UC-MUS-001 (Sign Up) | Scenarios 3,4,11 |
 | Musician ↔ Genre | M:N | UC-MUS-006 (Filter) | Scenarios 7,8 |
 | Band ↔ Event | 1:N | UC-BM-005 (Publish), UC-BM-006 (Cancel) | Scenarios 1,2,12 |
 | Band ↔ Instrument | M:N | UC-BM-002 (Edit Band Profile) | Scenario 9 |
 | Band ↔ Release | 1:N | UC-BM-008 (Publish Release) | Scenarios 5,6 |
 | Band ↔ Genre | M:N | UC-BM-008 (Publish Release) | Scenario 13 |
 | Event ↔ Signup | 1:N | UC-MUS-001 (Sign Up), UC-BM-007 (Review Signups) | Scenarios 3,4,11,12 |
 | Release ↔ Genre | N:1 | UC-BM-008 (Publish Release) | Scenario 13 |

---

## 4. Top-3 Discrepancies Between Spec and Artifacts

### Discrepancy 1: Band as Entity vs Actor

- **Spec**: Band is defined as an **entity** with attributes (id, name, email, info) and relationships to Event, Release, Genre, Instrument
- **Artifacts**: Band is **not an actor**; Band Member (a specialized Musician) performs all Band-related actions
- **Impact**: **None** — Correct design decision. Band is a data entity, not a user role. Band Member acts on behalf of Band.

### Discrepancy 2: Missing Capacity Attribute in Event

- **Spec**: Event entity has attributes (id, band_id, name, info, location, date) — **no capacity field**
- **Artifacts**: EARS-IF-002 references **"Event reaches capacity"** without a defined attribute
- **Impact**: **Medium** — Requirement cannot be implemented as specified. Either add `capacity: int` to Event or remove EARS-IF-002.

### Discrepancy 3: Undefined "Active" Status for Signup

- **Spec**: Signup entity has attributes (id, event_id, musician_id, info) — **no status field**
- **Artifacts**: EARS-ST-002 references **"active Signups"** without a defined status
- **Impact**: **Low** — Can be interpreted as "any existing Signup," but the term is ambiguous. Either add `status: string` to Signup or remove "active" qualifier.

---
---

## 5. Uncovered Elements Summary

### Uncovered Requirements

 | **ID** | **Description** | **Reason** | **Impact** |
 | -------- | ---------------- | ------------ | ------------ |
 | EARS-EV-002 | When Band updates Event, system shall validate changes and persist the updated Event | No UC for Event update (only publish/cancel exist) | Medium - Missing core CRUD operation |
 | EARS-EV-005 | When Musician updates profile, system shall validate and persist changes | No scenario for profile editing in scenarios.feature | Low - Covered by UC but not tested |
 | EARS-EV-007 | When Band deletes Release, system shall remove it if no dependencies exist | No UC or scenario for Release deletion | Medium - Missing core CRUD operation |
 | EARS-ST-002 | While Musician has active Signups, system shall prevent Musician deletion | No UC or scenario for Musician deletion prevention | Medium - Referential integrity gap |
 | EARS-ST-004 | While Band has published Events or Releases, system shall prevent Band deletion | No UC or scenario for Band deletion prevention | Medium - Referential integrity gap |
 | EARS-OP-001 | Where Musician specifies Instruments, system shall enable instrument-based Band filtering | No scenario for instrument-based filtering in scenarios.feature | Low - Optional feature |
 | EARS-NF-001 | System shall respond to all API requests within 500ms under normal load | Requires performance testing infrastructure | Medium - Non-functional, separate testing needed |

### Uncovered Use Cases

 | **ID** | **Description** | **Reason** | **Impact** |
 | -------- | ---------------- | ------------ | ------------ |
 | UC-MUS-002 | Create Musician Profile | No scenario in scenarios.feature | Low |
 | UC-MUS-003 | Edit Musician Profile | No scenario in scenarios.feature | Low |
 | UC-MUS-005 | View Event Details | No scenario in scenarios.feature | Low |
 | UC-MUS-007 | Filter Bands by Instrument | No scenario in scenarios.feature | Low |
 | UC-MUS-008 | View Band Profile | No scenario in scenarios.feature | Low |
 | UC-MUS-009 | Write Signup Note | No scenario in scenarios.feature | Low |
 | UC-MUS-010 | Cancel Signup | No scenario in scenarios.feature | Medium |
 | UC-MUS-011 | View Contact Info | No scenario in scenarios.feature | Low |
 | UC-BM-001 | Create Band | No scenario in scenarios.feature | Medium |
 | UC-BM-002 | Edit Band Profile | No scenario in scenarios.feature | Low |
 | UC-BM-003 | Invite Musician to Band | No scenario in scenarios.feature | Medium |
 | UC-BM-004 | Leave Band | No scenario in scenarios.feature | Medium |
 | UC-BM-007 | Review Event Signups | No scenario in scenarios.feature | Medium |
 | UC-SYS-003 | Send Email Notification | No scenario in scenarios.feature | Low |
 | UC-SYS-004 | Verify Band Membership | No scenario in scenarios.feature | Medium |

**Total Scenarios in scenarios.feature: 13**
