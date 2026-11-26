# ADR 0003 — Transfer consistency and idempotency

**Status:** Accepted

## Context
Accounts Service owns balances; Transfers Service must not access `accounts_db`. Clients and the network may retry requests.

## Decision
- Debit and credit run in a single local transaction inside Accounts Service, with optimistic locking (`version`).
- Transfers Service enforces `Idempotency-Key` with a unique constraint; Accounts Service deduplicates postings by `transferId`.
- No distributed transactions (2PC), no messaging in the MVP.

## Consequences
- The money movement itself is atomic and cannot be applied twice.
- The transfer status in `transfers_db` can lag behind (stuck in `PROCESSING`) after a crash. Documented as a known
  limitation; fixable with reconciliation, Outbox or Saga.
