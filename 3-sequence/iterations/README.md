# Iterations from previous labs

This directory contains the Task 1 and Task 2 artifacts as revised for the Task 3 specification. These are the versions to use when reviewing the sequence diagrams in this lab; the original submissions remain unchanged in their own directories.

## Source of truth

The Task 3 specification in ../spec.md has priority over earlier Task 2 artifacts. The 15 scenarios in scenarios.feature cover all original Gherkin cases, the new acceptance cases for incomplete Band profiles and sequential capacity rejection, and the updated Event cancellation behavior.

## Model iterations

- erDiagram.mmd retains the existing entities and relationships, includes Event.capacity and Notification, and records Event.status because the specification and acceptance criteria refer to published Events.
- use-cases-update.md specifies the changes to UC-MUS-001, UC-BM-005, UC-BM-006 and UC-SYS-003 without duplicating the full Task 2 catalog.
- requirements-update.md replaces the older Event deletion and Signup notification rules with the current specification.
- scenarios.feature is the revised Gherkin baseline for the 15 diagrams.

No new ADR is introduced for these iterations: they are direct alignment changes required by the current lab specification. Existing ADRs in the lab history are retained as historical records.
