# Use-case iterations for Task 3

The Task 2 catalog remains the baseline. Apply the following replacements when reading it alongside this lab's specification.

## UC-MUS-001: Sign Up for Event

- Preconditions: the Musician is registered and the Event is published.
- Main success flow:
  1. The Musician submits a signup request for the Event, optionally providing info.
  2. The system validates the Musician, Event, input, duplicate constraint and remaining capacity.
  3. The system creates a Signup linked to the Musician and Event.
  4. The system notifies the Band that owns the Event by email and on the site, recording one Notification per channel.
- Postconditions: Signup exists; both Band notification channels have been processed/recorded.
- Extensions: duplicate Signup is rejected; a full Event is rejected; concurrent requests are serialized so that capacity cannot be exceeded.

## UC-BM-005: Publish Event

The Band Member must belong to the Band and the Band profile must be complete. Submitted Event details include capacity. The system validates the date and other attributes before creating the Event with status published.

## UC-BM-006: Cancel Event

The prior precondition that no Signups exist is removed. After verifying Band membership, the system retrieves all Signups for the Event, notifies every affected Musician by email and on the site, deletes the related Signups, and then deletes the Event. This behavior supersedes the earlier Task 2 scenario that rejected Event deletion when Signups existed.

## UC-SYS-003: Send Notification

A notification is delivered through two channels: email via the external Email Service and an on-site Notification record. One Notification record is stored per channel. For Signup creation/deletion the Band is notified; when the Band cancels an Event, affected Musicians are notified.

## Domain constraints

- Event.capacity is a positive integer and the number of Signups must never exceed it.
- A Musician may have at most one Signup for a given Event.
- Event.status includes published as a valid state used by the use cases.
- Event cancellation is a cascading business workflow: notify affected Musicians, delete Signups, then delete Event.
