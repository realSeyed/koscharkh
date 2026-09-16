# Architecture Decision Records (ADR) Registry

This registry tracks all architectural decision records governing the KosCharkh application, its presentation system, domain boundaries, data layer, and engineering policies.

## Decision Lifecycle

Each ADR progresses through the following standard lifecycle:

- **Proposed**: The decision is under active architectural review and open for RFC discussion.
- **Accepted**: The decision is approved, active, and strictly enforced across the codebase.
- **Superseded**: The decision has been replaced by a newer ADR (referenced in `superseded_by`).
- **Deprecated**: The decision is no longer relevant or has been phased out without a direct replacement.

---

## ADR Registry Table

| ID | Title | Status | Scope | Last Updated | Link |
|---|---|---|---|---|---|
| `0001` | Design System and UI Tokens Governance | `Accepted` | `lib/features/**/presentation/**` | 2026-09-16 | [`0001-design-system-and-ui-tokens.md`](0001-design-system-and-ui-tokens.md) |
| `0002` | State Management BLoC vs Cubit Boundaries and State Mutation Invariants | `Accepted` | `lib/src/features/**/application/**, lib/src/core/routing/**` | 2026-09-17 | [`0002-state-management-bloc-vs-cubit-boundaries.md`](0002-state-management-bloc-vs-cubit-boundaries.md) |
| `0003` | Coordinate Isolation and Mapbox Contracts | `Accepted` | `lib/src/features/**/domain/**, lib/src/features/**/data/**, lib/src/core/map/**` | 2026-09-17 | [`0003-coordinate-isolation-and-mapbox-contracts.md`](0003-coordinate-isolation-and-mapbox-contracts.md) |
| `0004` | Isar Persistence and Cascade Rules | `Accepted` | `lib/src/core/storage/**, lib/src/features/**/data/**` | 2026-09-16 | [`0004-isar-persistence-and-cascade-rules.md`](0004-isar-persistence-and-cascade-rules.md) |

---

## Authoring Guidelines

1. **Naming Convention**: `docs/adr/<NNNN>-<kebab-case-title>.md`, zero-padded to 4 digits.
2. **Required Frontmatter**:
   ```yaml
   ---
   id: "<NNNN>-<kebab-case-title>"
   title: "Human Readable Title"
   status: "proposed | accepted | superseded | deprecated"
   applies_to: ["<glob-pattern>"]
   supersedes: null
   superseded_by: null
   tags: [tag1, tag2]
   ---
   ```
3. **Normative Directives**: ADRs must state enforceable requirements using RFC 2119 keywords (`MUST`, `MUST NOT`, `SHOULD`, `SHOULD NOT`, `MAY`).
4. **Machine Actionability**: Whenever an ADR prohibits or mandates a coding pattern, it must supply automated verification commands (e.g. `rg` / `git grep`) for CI integration.
