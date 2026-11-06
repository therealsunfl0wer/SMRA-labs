# Audit of the UC-MUS-001 sequence diagrams against the ER model and Gherkin scenarios

## Status
Accepted

## Context and problem statement
Task 3 requires one sequence diagram per Gherkin scenario of a chosen use case. UC-MUS-001 (Sign Up for Event) is covered by scenarios 3 (successful signup), 4 (duplicate signup) and 11 (concurrent signups at capacity) in `scenarios.feature`. The diagrams must use participants that match the Task 1 ER model and steps that match the Task 2 Gherkin scenarios. The first draft exposed gaps in both inputs (see ADR 3 and ADR 4). Which participants and steps do the final diagrams show, and what is still open after the model was amended?

## Decision drivers
- Participants correspond to ER entities, or to layers and external systems that hold no domain data.
- A participant that holds data and relates directly to an entity belongs in the ER model (ADR 3, ADR 4).
- Diagram steps match Gherkin Given/When/Then steps; extra steps are listed.
- Every diagram has at least one alt/opt/loop/par fragment, realistic call names and activation bars that never break inside one branch.

## Considered options
- UC-MUS-001 Sign Up for Event, scenarios 3, 4, 11 (chosen).
- UC-BM-005 Publish Event, scenarios 1, 2.
- UC-BM-008 Publish Release, scenarios 5, 6.

## Decision outcome
Chosen: model UC-MUS-001. Its three scenarios need `alt` (rejections), `opt` (optional note), `par` (two notification channels, two simultaneous signups) and `loop` (retry on serialization failure) and exercise the capacity and notification changes of ADR 3 and ADR 4.

Bar convention, verified on all three diagrams with a script: a participant that works outside a fragment or across several branches (WebClient, SignupController, SignupService; in scenario 3 also NotificationRepository across the `par`; in scenario 11 also EventRepository, SignupRepository, Database) is activated before the fragment and deactivated after it. A participant used in only one branch opens and closes its bar inside that branch. No bar starts or ends inside a branch it does not fully belong to.

## Audit 1: participants versus the ER model (Task 1)

| Participant | Kind | ER counterpart | Verdict |
| :-- | :-- | :-- | :-- |
| Musician (actor) | Actor | Musician | Match |
| MusicianRepository | Repository | Musician | Match |
| EventRepository | Repository | Event (reads `band_id`, `capacity`) | Match |
| BandRepository | Repository | Band (reads `email`) | Match |
| SignupService | Domain service | Signup | Match |
| SignupRepository | Repository | Signup | Match |
| NotificationService | Domain service | Notification | Match |
| NotificationRepository | Repository | Notification | Match |
| EmailService | External system | Actor in the Task 2 catalog, not an entity | Match with Task 2 |
| WebClient | UI layer | None, holds no domain data | Layer, no ER change needed |
| SignupController | REST layer | None, holds no domain data | Layer, no ER change needed |
| Database | Persistence infrastructure | Stores the ER entities, is not an entity | Layer, no ER change needed |

No participant is left that holds data without an ER counterpart. `CapacityProvider` from the first draft was removed by ADR 3.
Entities not used by UC-MUS-001: Genre, Instrument, Release. This is expected because the UC does not touch them.

## Audit 2: diagram steps versus Gherkin scenarios (Task 2)

| Scenario | Gherkin step | Diagram message(s) | Verdict |
| :-- | :-- | :-- | :-- |
| 3 | Given Musician 1 exists | `MusicianRepository.findById(1)` | Match |
| 3 | Given Event 1 exists | `EventRepository.findById(1)` returns `Event(id=1, band_id=3, capacity=5, date)` | Match |
| 3 | When Musician 1 signs up for Event 1 with info "Available" | `clickSignUp`, `createSignup(1, 1, Available)` | Match |
| 3 | Then a Signup is created linking Musician 1 to Event 1 | `SignupRepository.insert(Signup(musician_id=1, event_id=1, ...))` | Match |
| 3 | And the Band is notified by email | `EmailService.sendEmail(band.email, ...)` in the email lane | Match |
| 3 | And a Notification with channel "site" is recorded | `NotificationRepository.insert(Notification(..., channel=site, ...))` | Match |
| 3 | (not in Gherkin) | `existsByMusicianIdAndEventId`, `countByEventId`, `validateInfo`, email Notification record | Extra steps from UC extensions 2a, 2b and UC-MUS-009 |
| 4 | Given a Signup already exists for Musician 1 and Event 1 | `existsByMusicianIdAndEventId` returns true | Match |
| 4 | When Musician 1 attempts to sign up again | `clickSignUp`, `createSignup` | Match |
| 4 | Then reject with "Already signed up for this event" | `SignupRejected(ALREADY_SIGNED_UP)`, 409, `showError` | Match |
| 4 | (not in Gherkin) | Else branch with a UNIQUE violation | Extra, defense in depth |
| 11 | Given Event 1 with capacity 5 and 4 Signups | `findById(1)` returns `capacity=5`; the count is checked inside `insertIfBelowLimit` | Match |
| 11 | When 2 Musicians simultaneously attempt to sign up | `par` with two lanes | Match |
| 11 | Then exactly one signup succeeds | Lane A: `SignupCreated` | Match |
| 11 | And the other is rejected with "Event full" | Lane B: `SignupRejected(EVENT_FULL)`, 409 | Match |
| 11 | (not in Gherkin) | `notifyBand` in lane A, `loop` retry on SerializationFailure | Extra, from UC-MUS-001 step 4 and implementation detail |

UC-MUS-001 step 1 (view Event details, UC-MUS-005) is not drawn because the Gherkin scenarios start at the signup action; it is recorded in a Note.

## Resolved by the model iteration
| Earlier finding | Resolution |
| :-- | :-- |
| Capacity absent from the ER model | `Event.capacity` added (ADR 3) |
| Event-Signup minimum cardinality "one or many" contradicted the flows | Changed to "zero, one, or many" in Task 1 |
| UC-MUS-001 did not reference the Email Service or UC-SYS-003 | UC-MUS-001 includes UC-SYS-003; Notification entity added (ADR 4) |
| UC-MUS-001 did not list the UC-SYS-001 include | Added to `use-cases.md`, matching the use case diagram |

## Top-3 discrepancies (open)

### 1. One Signup per Musician per Event is not enforceable in the model (Medium)
- The rule exists only as text ("at most one per Event"); ADR 1 admits that the surrogate key does not prevent duplicates, and no UNIQUE(event_id, musician_id) is specified.
- Effect on diagrams: scenario 4 relies on a pre-check and a database constraint, scenario 11 on an atomic conditional insert; neither is stated in the model.
- Proposed fix: note a UNIQUE(event_id, musician_id) rule on Signup in Task 1.

### 2. Event "published" status is not in the model (Medium)
- The UC-MUS-001 precondition ("Event is published"), EARS-EV-001 and Gherkin scenario 1 ("status published") use a status, but Event has no status attribute and scenario 3 only says "Event exists".
- Effect on diagrams: no step can verify that the Event is published.
- Proposed fix: add `string status` to Event, or drop "published" from the precondition.

### 3. Notification values are undefined in the model (Low)
- `Notification.channel` and `Notification.status` are strings; their allowed values (`email`, `site`; `sent`, `failed`, `unread`, `read`) are defined only in ADR 4. Gherkin scenario 3 mentions only channel "site", and there is no scenario for a failed email.
- Effect on diagrams: the literals in the `Notification` inserts and the `failed` status are not backed by Gherkin.
- Proposed fix: add the value lists to the Task 1 spec and a scenario for email failure if it must be diagrammed.

## Other findings (not in top 3)
- Capacity validation (a positive integer) and lowering `capacity` below the current number of Signups have no requirement or scenario.
- No scenario covers a plain, sequential "Event at capacity" case; scenario 11 covers concurrency only.
- `useCase.png` is not re-rendered after the UC-MUS-001 to UC-SYS-003 include was added to `useCase.puml`.

## Consequences
- Good: every Gherkin scenario of UC-MUS-001 has its own diagram, and every participant is either an ER-backed entity participant, an external system from the Task 2 catalog, or a layer without domain data.
- Good: the diagrams exposed three model gaps that are now fixed (ADR 3, ADR 4, cardinality).
- Bad: three layers (WebClient, SignupController, Database) exist only for the interaction view.
- Bad: three discrepancies stay open and need a follow-up in Task 1.

## Pros and cons of the options

### UC-MUS-001
- Good: covers alt, opt, par and loop with a natural scenario for each.
- Bad: its data model gaps required changes to two earlier labs.

### UC-BM-005 Publish Event
- Good: simpler, fewer participants.
- Bad: no concurrency or loop.

### UC-BM-008 Publish Release
- Good: uses both external systems.
- Bad: only two scenarios and no shared state that needs parallel branches.
