# Requirements updates for Task 3

This file is a focused replacement for the Task 2 requirements whose behavior is clarified or superseded by the Task 3 specification. All other EARS requirements remain unchanged.

| Requirement | Updated wording |
| --- | --- |
| EARS-EV-001 | When a Band Member with verified membership submits valid Event details and the Band profile is complete, the system shall create an Event with status published, including its positive integer capacity. |
| EARS-EV-003 | When an authorized Band Member cancels an Event, the system shall notify every Musician with a related Signup through email and on-site notification, delete the related Signups, and then delete the Event. |
| EARS-EV-008 | When a Signup is created or deleted, the system shall notify the Band that owns the Event by email and on the site, recording one Notification per channel. |
| EARS-IF-002 | If the number of Signups for an Event is equal to its capacity, the system shall reject any further Signup with the error Event full. Concurrent Signup requests shall not cause capacity to be exceeded. |
| EARS-IF-005 | If a Band Member submits an Event date that is not in the future or is not a valid ISO 8601 date, the system shall reject Event publication with a specific date validation error. |
| EARS-ST-001 | When an authorized Band Member cancels an Event with Signups, the system shall notify affected Musicians, delete the Signups, and delete the Event; it shall not reject cancellation solely because Signups exist. |

## Clarifications

- The older rule preventing Event deletion while Signups exist is superseded by the current Task 3 specification.
- The older Task 2 Gherkin deletion scenario is replaced by the cancellation workflow.
- Signup.status is not introduced: the cancellation rule applies to all Signups associated with the Event.
- Event.capacity is stored on Event; the current Signup count is derived from Signup records.
