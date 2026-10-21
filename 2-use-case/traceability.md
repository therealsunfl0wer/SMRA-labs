# Rent-a-Gig Traceability Matrix

## Requirements to Use Cases to Scenarios to Entities

   **Requirement ID** | **Use Cases** | **Scenarios** | **Entities** | **Coverage** |
 | ------------------- | --------------- | --------------- | -------------- | -------------- |
 | **EARS-UB-001** | UC-MUS-001, UC-MUS-002, UC-MUS-003, UC-MUS-004, UC-MUS-005, UC-MUS-006, UC-MUS-007, UC-MUS-008, UC-MUS-009, UC-MUS-010, UC-MUS-011, UC-BM-001, UC-BM-002, UC-BM-003, UC-BM-004, UC-BM-005, UC-BM-006, UC-BM-007, UC-BM-008, UC-SYS-001, UC-SYS-002, UC-SYS-003, UC-SYS-004 | 1,2,3,4,5,6,7,8,9,10,11,12,13 | Musician, Band, Event, Instrument, Signup, Release, Genre | covered |
 | **EARS-UB-002** | All UC | All scenarios | All entities | covered |
 | **EARS-UB-003** | All UC | All scenarios | All entities | covered |
 | **EARS-UB-004** | All UC | All scenarios | All entities | covered |
 | **EARS-UB-005** | All UC | All scenarios | All entities | covered |
 | **EARS-UB-006** | All UC | All scenarios | All entities | covered |
 | **EARS-EV-001** | UC-BM-005, UC-BM-002 | 1,2 | Band, Event | covered |
 | **EARS-EV-002** | None | None | Band, Event | uncovered |
 | **EARS-EV-003** | UC-BM-006 | 12 | Band, Event, Signup | covered |
 | **EARS-EV-004** | UC-MUS-001, UC-MUS-009, UC-MUS-010 | 3,4,11 | Musician, Event, Signup | covered |
 | **EARS-EV-005** | UC-MUS-003 | None | Musician | uncovered |
 | **EARS-EV-006** | UC-BM-008 | 5,6 | Band, Release, Genre | covered |
 | **EARS-EV-007** | None | None | Band, Release | uncovered |
 | **EARS-ST-001** | UC-BM-006, UC-BM-005 | 12 | Event, Signup | covered |
 | **EARS-ST-002** | None | None | Musician, Signup | uncovered |
 | **EARS-ST-003** | UC-BM-006, UC-BM-008 | 12,13 | Genre, Release, Band | covered |
 | **EARS-ST-004** | None | None | Band, Event, Release | uncovered |
 | **EARS-IF-001** | UC-MUS-001, UC-SYS-001 | 4 | Signup, Musician, Event | covered |
 | **EARS-IF-002** | UC-MUS-001, UC-BM-005 | 11 | Event, Signup | covered |
 | **EARS-IF-003** | UC-SYS-001 | 2,6 | All entities | covered |
 | **EARS-IF-004** | UC-SYS-001 | All scenarios | All entities | covered |
 | **EARS-IF-005** | UC-BM-005, UC-SYS-001 | 2 | Event | covered |
 | **EARS-IF-006** | UC-BM-008, UC-SYS-002 | 6 | Release | covered |
 | **EARS-OP-001** | UC-MUS-007 | None | Musician, Instrument, Band | uncovered |
 | **EARS-OP-002** | UC-BM-002 | 9 | Band, Instrument | covered |
 | **EARS-OP-003** | UC-MUS-006 | 7,8 | Musician, Band, Genre | covered |
 | **EARS-NF-001** | None | None | All entities | uncovered |
 | **EARS-NF-002** | All UC | 11 | All entities | covered |
 | **EARS-NF-003** | UC-SYS-001 | All scenarios | All entities | covered |

---

## Uncovered Elements

### Uncovered Requirements

 | **ID** | **Description** | **Reason** | **Impact** |
 | -------- | ---------------- | ------------ | ------------ |
 | EARS-EV-002 | When Band updates Event, system shall validate changes and persist the updated Event | No UC for Event update (only publish/cancel exist) | Medium - Missing core CRUD operation |
 | EARS-EV-005 | When Musician updates profile, system shall validate and persist changes | No scenario for profile editing in scenarios.feature | Low - Covered by UC-MUS-003 but not tested |
 | EARS-EV-007 | When Band deletes Release, system shall remove it if no dependencies exist | No UC or scenario for Release deletion | Medium - Missing core CRUD operation |
 | EARS-ST-002 | While Musician has active Signups, system shall prevent Musician deletion | No UC or scenario for Musician deletion prevention | Medium - Referential integrity gap |
 | EARS-ST-004 | While Band has published Events or Releases, system shall prevent Band deletion | No UC or scenario for Band deletion prevention | Medium - Referential integrity gap |
 | EARS-OP-001 | Where Musician specifies Instruments, system shall enable instrument-based Band filtering | No scenario for instrument-based filtering in scenarios.feature | Low - Optional feature |
 | EARS-NF-001 | System shall respond to all API requests within 500ms under normal load | Requires performance testing infrastructure | Medium - Non-functional, separate testing needed |

### Uncovered Use Cases

 | **ID** | **Description** | **Reason** | **Impact** |
 | -------- | ---------------- | ------------ | ------------ |
 | UC-MUS-002 | Create Musician Profile | No scenario in scenarios.feature | Low - Registration flow not tested |
 | UC-MUS-003 | Edit Musician Profile | No scenario in scenarios.feature | Low - Profile management not tested |
 | UC-MUS-005 | View Event Details | No scenario in scenarios.feature | Low - View-only operation |
 | UC-MUS-007 | Filter Bands by Instrument | No scenario in scenarios.feature | Low - Optional filtering |
 | UC-MUS-008 | View Band Profile | No scenario in scenarios.feature | Low - View-only operation |
 | UC-MUS-009 | Write Signup Note | No scenario in scenarios.feature | Low - Optional feature |
 | UC-MUS-010 | Cancel Signup | No scenario in scenarios.feature | Medium - Core functionality missing |
 | UC-MUS-011 | View Contact Info | No scenario in scenarios.feature | Low - View-only operation |
 | UC-BM-001 | Create Band | No scenario in scenarios.feature | Medium - Core Band creation missing |
 | UC-BM-002 | Edit Band Profile | No scenario in scenarios.feature | Low - Profile management not tested |
 | UC-BM-003 | Invite Musician to Band | No scenario in scenarios.feature | Medium - Core Band membership missing |
 | UC-BM-004 | Leave Band | No scenario in scenarios.feature | Medium - Core Band membership missing |
 | UC-BM-007 | Review Event Signups | No scenario in scenarios.feature | Medium - Core Band management missing |
 | UC-SYS-003 | Send Email Notification | No scenario in scenarios.feature | Low - External system interaction |
 | UC-SYS-004 | Verify Band Membership | No scenario in scenarios.feature | Medium - Permission system not tested |

**Total Scenarios in scenarios.feature: 13**
