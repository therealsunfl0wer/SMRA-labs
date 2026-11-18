# Requirements updates for Task 3

This document lists only the Task 2 EARS requirements whose wording is superseded or clarified by the current Task 3 specification. All other requirements remain unchanged in the original Task 2 directory.

| Requirement | Updated wording |
| --- | --- |
| EARS-EV-001 | When an authorized Band Member submits valid Event details and the Band profile is complete, the system shall create an Event with status "published" and persist the submitted capacity. |
| EARS-EV-003 | When an authorized Band Member cancels an Event, the system shall notify every Musician with a related Signup by email and on the site, delete the related Signups, and then delete the Event. |
| EARS-EV-008 | When a Signup is created or deleted, the system shall notify the Band that owns the Event by email and on the site, recording one Notification per channel. |
| EARS-IF-002 | If the number of Signups for an Event equals Event.capacity, the system shall reject a new Signup with the error "Event full". Concurrent Signup requests shall not cause the number of Signups to exceed Event.capacity. |
| EARS-IF-005 | If a Band Member submits an Event date that is not a valid ISO 8601 date or is not in the future, the system shall reject Event publication with a specific date validation error. |
| EARS-ST-001 | When an authorized Band Member cancels an Event with Signups, the system shall notify affected Musicians, delete the related Signups, and delete the Event. The system shall not reject cancellation solely because Signups exist. |

## Clarifications

- The Task 3 specification supersedes the earlier Task 2 rule that prevented Event deletion while Signups existed.
- Event cancellation is a business workflow, not a direct database cascade: notify affected Musicians first, delete related Signups second, and delete the Event last.
- Signup.status is not introduced. The cancellation rule applies to all Signups associated with the Event.
- Event.capacity is stored on Event; the current Signup count is derived from Signup records.
- The specification does not define the data type or lower bound of Event.capacity. This iteration does not add a positivity rule that is absent from the source specification.
- The specification requires one Notification per channel (`email` and `site`) but does not define Notification delivery-status values.
