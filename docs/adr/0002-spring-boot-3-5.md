# ADR 0002 — Spring Boot 3.5.x and Spring Cloud 2025.0.x

**Status:** Accepted

## Context
Spring Boot 4.0 was released in November 2025. Spring Boot 3.5.16 (June 2026) is the last open-source release of the 3.5 line,
and Spring Cloud 2025.0.3 is the last open-source release of its train. Most banking codebases still run on Boot 3.x.

## Decision
Use Spring Boot 3.5.16 + Spring Cloud 2025.0.3 on Java 21.

## Consequences
- The stack mirrors what is common in enterprise/banking environments today.
- 3.5.x no longer receives OSS patches: this is acceptable for a portfolio project, **not** for production.
- A future step is migrating to Boot 4.x / Spring Cloud 2025.1.x (Jakarta EE 11, Spring Framework 7).
