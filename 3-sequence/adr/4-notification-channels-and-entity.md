# Notify the Band by email and on the site, and store Notifications as an entity

## Status
Accepted

## Context and problem statement
When a Musician signs up for an Event, the Band that owns the Event has to learn about it. The product requirement is to deliver this notice both by email and on the site. UC-MUS-001 did not reference the Email Service at all, UC-SYS-003 only described email, and the ER model had no place to keep an on-site notice. The sequence diagram for scenario 3 needs a participant for the on-site channel that holds data and has a direct relationship with `Signup`, so it cannot be treated as a plain layer. How should notifications be modeled?

## Decision drivers
- Notifications must reach the Band through two channels: email (external Email Service) and the site.
- A participant that holds data and relates directly to an entity belongs in the ER model.
- Task 1 rules: single-column `int id` keys, foreign keys only on the "many" side, snake_case attributes, 4NF.
- The Task 1 assumption said that communication takes place outside of the project; this concerns negotiation between users, not system notices.
- UC-MUS-001 has to include the notification use case, as UC-BM-003, UC-BM-006 and UC-BM-008 already do.

## Considered options
- Email only, no stored data.
- Email plus an on-site notice computed from Signups, with no new entity.
- Email plus a stored `Notification` entity, one record per channel (chosen).

## Decision outcome
Chosen: add a `Notification` entity with `id`, `signup_id` (FK), `channel` and `status`, related to `Signup` as zero, one, or many Notifications per Signup.

Each delivery is one record. The recipient is not stored because it is derived through `Signup.event_id`, `Event.band_id` and `Band.email`. The email channel is sent through the Email Service (an external system, not an entity) using `Band.email`; the on-site channel is a stored record that Band Members read on the site. In the current design `channel` takes `email` or `site`, and `status` takes `sent`, `failed`, `unread` or `read`.

UC-SYS-003 is renamed from "Send Email Notification" to "Send Notification" and is included by UC-MUS-001. The Task 1 assumption is narrowed to "communication between users".

## Consequences
- Good: both channels are explicit in the model, and the sequence diagram participants `NotificationService` and `NotificationRepository` map to the `Notification` entity.
- Good: the model stays in 4NF because `channel` and `status` depend only on `Notification.id`.
- Good: delivery results (`sent`, `failed`) can be audited without a separate log.
- Bad: the model grows by one entity, one relationship and one foreign key.
- Bad: `channel` and `status` are free strings in the ER specification, so their allowed values live only in this ADR and in the requirements.
- Bad: UC-SYS-003 now creates data, so UC-SYS-003, EARS requirements, Gherkin scenario 3 and the traceability matrix need an iteration.
- Bad: reading and marking on-site notices as read is not covered by any use case yet.

## Pros and cons of the options

### Email only
- Good: no change to the model.
- Bad: does not satisfy the on-site requirement.

### Computed on-site notice
- Good: no new entity, since a Band Member could see new Signups through UC-BM-007.
- Bad: no read state and no delivery record, and it is not a push of information to the Band.

### Stored Notification entity
- Good: one model for both channels, with a delivery status per channel.
- Bad: extra entity and an iteration over Task 2 artifacts.
