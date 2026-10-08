# Target 4NF for the ER model

## Status
Accepted

## Context and problem statement
Which normal form should the model be required to satisfy, and why?

The specification explicitly requires the model to conform to 4NF. The model contains entities with multiple independent multi-valued relationships. For example, musicians can play multiple instruments and perform multiple genres, while bands can utilize multiple instruments and represent multiple genres. These facts should be represented as separate relationships rather than stored together as repeating or combined values.

## Considered options
- 3NF
- 4NF

## Decision outcome
Chosen: require the model to satisfy 4NF.

This choice is  appropriate for the model's structure: each entity has a single-column identifier, and multi-valued facts are represented through relationships between entities instead of being combined into a single attribute. For example, musician-instrument and musician-genre associations are modeled separately, as are band-instrument and band-genre associations.

## Consequences
- Good: makes the explicit 4NF acceptance criterion part of the design decision.
- Good: helps avoid redundancy and update anomalies caused by storing independent multi-valued facts together.
- Good: gives each relationship a clear place in the model and keeps entity attributes focused on facts about that entity.
- Bad / risk: verifying 4NF requires identifying relevant dependencies, it is less straightforward to establish by visual inspection of an ER diagram alone.
- Bad / risk: the model and diagram must stay aligned when a relationship or attribute changes.

## Note on the options
### 3NF
- 3NF would be a perfectly good choice for the model, however, 4NF was met at minimum cost, which is why it became part of the specifications. 