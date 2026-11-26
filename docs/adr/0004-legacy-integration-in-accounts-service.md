# ADR 0004 — Legacy SOAP integration lives in Accounts Service

**Status:** Accepted

## Context
The project must show integration between a modern REST API and a legacy SOAP/XML core.

## Decision
Accounts Service consumes the legacy simulator's SOAP operation to query accounts and balances, and adapts the
JAXB-generated XML types to internal DTOs (anti-corruption layer). The transfer critical path does not depend on it.

## Consequences
- Legacy types never leak past the adapter.
- A legacy outage degrades only the legacy account query, not transfers.
