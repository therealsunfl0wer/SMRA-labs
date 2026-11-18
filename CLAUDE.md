# Repository conventions for AI-assisted work

## Repository structure and source priority

- Keep each laboratory's deliverables inside its numbered directory.
- Treat the current laboratory specification as authoritative for that laboratory.
- Do not silently rewrite earlier laboratory submissions. When a later specification supersedes an earlier artifact, create a focused iteration under the current laboratory's `iterations/` directory and link to it.
- Keep original files intact unless the repository owner explicitly requests a direct update.
- Do not duplicate a full prior artifact when a focused delta is sufficient.

## Artifact language and formats

- Write deliverable artifacts in English, including diagrams, specifications, audit documents, prompt reports, and commit messages.
- Use Markdown for explanatory documents and Mermaid source in standalone `.mmd` files for Mermaid diagrams.
- Keep source diagrams editable. Rendered images belong in a clearly named render directory and must be generated from the corresponding source.
- Use descriptive, stable filenames with zero-padded scenario numbers where ordering matters.
- Each required scenario must have exactly one canonical diagram. Remove or clearly mark obsolete duplicate drafts so they cannot be mistaken for canonical artifacts.
- Use realistic action names such as `submitSignup()`, `validateEvent()`, and `cancelEvent()`.
- Sequence diagrams should show actors, relevant domain entities/repositories, service or UI layers, external systems where applicable, request and return messages, activation bars, and suitable `alt`, `opt`, `loop`, or `par` fragments.
- Activation bars must be structurally consistent: a participant active across a combined fragment must remain active for the whole fragment; a participant used only in one branch should be activated and deactivated inside that branch.
- Keep sequence participants traceable to the ER model, or clearly identify them as non-persistent layers or external systems.

## Requirements traceability and iteration policy

- Align diagrams with the current Gherkin scenarios and the current laboratory specification.
- Preserve scenario intent and explicit acceptance outcomes. Do not add implementation-specific details unless the source specification requires them or the artifact labels them as an assumption.
- If the specification does not define a database engine, isolation level, status enumeration, data type, or cascade policy, do not present one as a fact.
- Put changes to earlier ER, use-case, requirements, or Gherkin artifacts in the current lab's `iterations/` directory. Explain which original rule is superseded.
- Create an ADR only for a genuine design decision with alternatives and consequences. A direct update required by a newer specification is an iteration, not an ADR.
- Maintain an audit that checks source priority, participant-to-model consistency, scenario coverage, and unresolved ambiguities.

## Git and pull-request conventions

- Every AI-authored repository change must be committed; do not leave requested edits uncommitted.
- Commit messages must begin with the exact prefix `ai: `.
- Every AI-authored commit must include a `Co-Authored-By` trailer identifying the actual model used for the contribution, for example:
  `Co-Authored-By: GPT-6 <gpt-6@openai.com>`
- Do not claim a co-author trailer was added unless the resulting commit message actually contains it. If the commit API or workflow cannot add trailers, use an authorized local Git workflow or a documented force-with-lease update to repair the commit metadata.
- Prefer one focused commit per logical change. Do not amend, rewrite, or force-push existing user commits merely for cosmetic consistency.
- When working on an existing pull request, push commits to its head branch and verify the PR's head/base refs before changing anything.
- If force-pushing is necessary to repair AI-authored commit metadata, use a lease/expected-head check and preserve all unrelated commits. Never overwrite unknown concurrent work.
- Do not create a new pull request when the task explicitly targets an existing PR. If no open PR exists, report that fact and ask before creating one.
- After each write, verify the commit SHA and inspect the resulting file or branch state.

## Validation

- Check Mermaid syntax with an available Mermaid renderer when possible.
- Review each diagram against its Gherkin scenario and the ER model.
- Check that scenario numbering is unique and that every required scenario has one canonical `.mmd` file.
- Verify every commit subject starts with `ai: ` and every commit body contains the co-author trailer.
- Report validation limitations honestly; do not claim a render or check succeeded unless it was actually run.
