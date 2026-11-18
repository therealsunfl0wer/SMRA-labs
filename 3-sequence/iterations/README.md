# Iterations from previous labs

This directory contains Task 1 and Task 2 artifacts revised for the Task 3 specification. These are the Task 3-aligned versions to use when reviewing the sequence diagrams. The original submissions remain in their original directories and are not rewritten by this lab.

## Source of truth

The current Task 3 specification in [../spec.md](../spec.md) has priority over earlier requirements, use cases, and Gherkin scenarios. Where an earlier artifact conflicts with the Task 3 specification, the iteration in this directory supersedes it for this lab.

The revised Gherkin baseline contains 15 scenarios:
- the original 13 Task 2 scenarios, with Event cancellation updated to the current specification;
- incomplete Band profile rejection;
- sequential rejection when Event capacity is reached.

Each scenario has one canonical Mermaid sequence diagram in [../diagrams](../diagrams/).

## Iterated artifacts

- [erDiagram.mmd](erDiagram.mmd) — Task 1 ER model with `Event.capacity`, the published Event state, and the `Notification` entity.
- [requirements-update.md](requirements-update.md) — focused EARS replacements for requirements superseded or clarified by Task 3.
- [use-cases-update.md](use-cases-update.md) — focused updates to UC-MUS-001, UC-BM-005, UC-BM-006, and UC-SYS-003.
- [scenarios.feature](scenarios.feature) — authoritative 15-scenario Gherkin baseline for the Task 3 diagrams.

## Modeling notes

- `Event.capacity` is stored on Event; the current number of Signups is derived from Signup records.
- The number of Signups must not exceed Event.capacity. The specification does not define a capacity data type or a lower-bound validation rule, so this iteration does not invent one.
- `Notification.channel` is restricted to `email` and `site`. The specification does not define delivery-status values; no status enumeration is assumed here.
- A Musician may not create duplicate Signups for the same Event. The pair is documented as a domain uniqueness constraint in the ER diagram.
- Event cancellation follows the Task 3 workflow: notify every affected Musician through both channels, delete the related Signups, and then delete the Event.
- Notification persistence after Signup deletion is not fully specified; this remains an audit finding rather than an invented cascade policy.

## Change and decision policy

Do not modify the original Task 1 or Task 2 submissions merely to make this lab consistent. Put Task 3-specific iterations in this directory and link them from the diagrams or audit.

Do not create an ADR for a straightforward update that directly aligns an earlier artifact with the current specification. Reserve ADRs for genuine design decisions where the specification leaves alternatives open. The consistency review is documented in [../audit.md](../audit.md).
