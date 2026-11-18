# Use-case iterations for Task 3

The Task 2 use-case catalog remains the baseline. Apply the following replacements when reading it alongside this lab's specification.

## UC-MUS-001: Sign Up for Event

- Preconditions: the Musician is registered and the Event is published.
- Main success flow:
  1. The Musician submits a Signup request for the Event and may provide additional information.
  2. The system validates the Musician, Event, input, duplicate constraint, and remaining capacity.
  3. The system creates a Signup linked to the Musician and Event.
  4. The system notifies the Band that owns the Event by email and on the site, recording one Notification per channel.
- Postconditions: the Signup exists and the Band has been notified through both channels.
- Extensions: duplicate Signup is rejected; a full Event is rejected; concurrent requests are handled atomically so Event.capacity cannot be exceeded.

## UC-BM-005: Publish Event

The Band Member must belong to the Band, and the Band profile must be complete. Submitted Event details include capacity. The system validates the date and other submitted attributes before creating the Event with status "published".

## UC-BM-006: Cancel Event

The earlier precondition that no Signups exist is removed. After verifying Band membership, the system retrieves all Signups for the Event, notifies every affected Musician by email and on the site, deletes the related Signups, and then deletes the Event. This behavior supersedes the earlier Task 2 scenario that rejected Event deletion when Signups existed.

## UC-SYS-003: Send Notification

A notification is delivered through two channels: email via the external Email Service and an on-site Notification record. One Notification record is stored per channel. When a Signup is created or deleted, the Band that owns the Event is notified. When the Band cancels an Event, every Musician with a related Signup is notified.

## Domain constraints and specification boundaries

- A Musician may have at most one Signup for a given Event.
- The number of Signups for an Event must not exceed Event.capacity.
- Event.status includes "published", which is used by the Task 3 use cases.
- Event cancellation is ordered: notify affected Musicians, delete related Signups, then delete the Event.
- Notification.channel is "email" or "site". The Task 3 specification does not define Notification delivery-status values or retention after the associated Signup is deleted.
- The Task 3 specification does not define the type or lower bound of Event.capacity; do not add a validation rule without an explicit requirement.
