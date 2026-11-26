# ADR 0001 — Small microservice architecture with database per service

**Status:** Accepted

## Context
The project must demonstrate microservice skills while staying a small, finishable MVP that runs locally for free.

## Decision
Five deployables (gateway, contacts, accounts, transfers, legacy simulator). One PostgreSQL container with three
logical databases and one dedicated DB user per service. No shared `common` library.

## Consequences
- Each service can evolve its schema independently; isolation is enforced by DB permissions, not only by convention.
- Small duplication (correlation ID filter, error handling) is accepted to avoid coupling releases.
- One Postgres container is a single point of failure — acceptable locally, not in production.
