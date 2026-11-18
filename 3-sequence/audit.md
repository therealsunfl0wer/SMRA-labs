# Task 3 Artifact Audit

## Scope and source priority

The current source of truth is [spec.md](spec.md). The diagrams cover the 15 scenarios in [iterations/scenarios.feature](iterations/scenarios.feature). Earlier Task 1 and Task 2 materials remain unchanged in their original directories; their Task 3-aligned replacements are in [iterations/](iterations/).

The current specification takes priority over earlier Task 2 rules where they conflict. In particular, Event cancellation now notifies affected Musicians, removes related Signups, and then removes the Event. The earlier rejection rule for deleting Events with Signups is superseded.

## Scenario-to-diagram coverage

| # | Gherkin scenario | Canonical sequence diagram |
| ---: | --- | --- |
| 1 | Band publishes a new Event | [scenario-01-publish-event.mmd](diagrams/scenario-01-publish-event.mmd) |
| 2 | Band tries to publish Event with incomplete profile | [scenario-02-incomplete-band-profile.mmd](diagrams/scenario-02-incomplete-band-profile.mmd) |
| 3 | Musician signs up for an Event | [scenario-03-signup-success.mmd](diagrams/scenario-03-signup-success.mmd) |
| 4 | Musician tries to sign up twice for same Event | [scenario-04-signup-duplicate.mmd](diagrams/scenario-04-signup-duplicate.mmd) |
| 5 | Musician signup is rejected when Event is full | [scenario-05-event-full.mmd](diagrams/scenario-05-event-full.mmd) |
| 6 | Band creates a Release | [scenario-06-create-release.mmd](diagrams/scenario-06-create-release.mmd) |
| 7 | Band tries to create Release with invalid URL | [scenario-07-invalid-release-url.mmd](diagrams/scenario-07-invalid-release-url.mmd) |
| 8 | Musician browses Bands by Genre | [scenario-08-filter-bands-by-genre.mmd](diagrams/scenario-08-filter-bands-by-genre.mmd) |
| 9 | Musician browses Bands by non-existent Genre | [scenario-09-no-bands-for-genre.mmd](diagrams/scenario-09-no-bands-for-genre.mmd) |
| 10 | Band manages Instruments | [scenario-10-band-manages-instruments.mmd](diagrams/scenario-10-band-manages-instruments.mmd) |
| 11 | Musician manages Instruments | [scenario-11-musician-manages-instruments.mmd](diagrams/scenario-11-musician-manages-instruments.mmd) |
| 12 | Concurrent Event signups at capacity | [scenario-12-concurrent-signups-capacity.mmd](diagrams/scenario-12-concurrent-signups-capacity.mmd) |
| 13 | Band cancels Event with Signups | [scenario-13-cancel-event-with-signups.mmd](diagrams/scenario-13-cancel-event-with-signups.mmd) |
| 14 | Band tries to publish Event with invalid date | [scenario-14-invalid-event-date.mmd](diagrams/scenario-14-invalid-event-date.mmd) |
| 15 | Genre deletion prevented by existing Release | [scenario-15-prevent-genre-deletion.mmd](diagrams/scenario-15-prevent-genre-deletion.mmd) |

## Participant consistency

Participants are grouped into:
- Domain entities represented in the Task 1 ER model: Musician, Band, Event, Signup, Release, Genre, Instrument, Notification.
- Persistence adapters/repositories that read or write those entities.
- Application services and controllers that coordinate requests but do not independently own domain data.
- External systems, notably Email Service.
- Human actors such as Musician, Band Member, and Administrator.

The NotificationService and NotificationRepository operate on the Notification entity added in the Task 1-aligned iteration. EmailService remains an external system rather than a persistent domain entity. WebClient, controllers, services, and Database are interaction/implementation layers, not ER entities.

## Behavioral consistency

- Event publication checks Band membership, Band profile completeness, and Event details before persisting a published Event with capacity.
- Signup creation checks the Musician, published Event, duplicate Signup constraint, and available capacity. Successful Signup creation notifies the owning Band through email and site channels.
- The capacity boundary is enforced as one atomic create-if-capacity-allows operation. The diagram deliberately avoids prescribing a database vendor or isolation level because the specification does not name one.
- Event cancellation verifies Band membership, notifies every affected Musician through both channels, deletes related Signups, and finally deletes the Event.
- Invalid dates, invalid Release URLs, missing Genre matches, and referential-integrity rejection are represented as alternative outcomes.

## Remaining ambiguities and limitations

1. **Notification retention after Signup deletion.** The specification requires Notifications to be recorded and Signups to be deleted but does not define whether Notification records retain a historical Signup identifier, are detached, or are removed. The ER iteration retains the existing Signup-to-Notification relationship without asserting a deletion policy. A later schema-level decision may be needed before implementation.
2. **Notification delivery status.** The specification requires one Notification per channel but does not define delivery-status values. The Task 3 ER iteration therefore omits a status attribute rather than inventing values such as `sent`, `failed`, or `unread`.
3. **Capacity validation details.** The specification establishes a signup limit but does not define the capacity type, minimum value, or behavior when capacity is edited below the current Signup count. Those constraints are not invented in the iteration.
4. **Signup notification on deletion.** FR-008 states that deleting a Signup notifies the owning Band, but the supplied 15 scenarios do not include a standalone Musician-cancels-Signup scenario. The use-case iteration records the requirement; no extra scenario is fabricated.
5. **Email delivery failure.** The specification does not define whether a failed email blocks Signup creation or Event cancellation. The diagrams show the required email and site channels but do not invent a failure policy.

## Diagram quality checks

- Every canonical scenario diagram includes at least one combined fragment.
- Calls use action-oriented names and include relevant return messages.
- Participants with work across a combined fragment remain active across the fragment; branch-local participants are activated and deactivated within their branch.
- The concurrency diagram depicts the required observable result (one success, one capacity rejection) without claiming a specific SQL isolation mechanism.

## Historical ADR policy

No new ADR is required for changes that simply align Task 1 or Task 2 artifacts with the current Task 3 specification. Existing ADRs are retained as historical records. This audit is a consistency report, not an architectural decision record.
