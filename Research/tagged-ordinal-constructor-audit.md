# Tagged Ordinal Constructor Audit

<!--
---
version: 1.0.0
last_updated: 2026-02-06
status: RECOMMENDATION
---
-->

## Context

`Algebra.Z<n>` needs a throwing `init(_ : Ordinal) throws(Error)` for bounds-checked construction, following the Swift Institute pattern where `try` indicates validation. This conflicts with an inherited blanket `init(_ position: Ordinal)` (non-throwing) from `Tagged+Ordinal.swift` in ordinal-primitives, which applies to ALL `Tagged<_, Ordinal>` types.

Investigation reveals this blanket init is not just a conflict for Algebra.Z — it is a systemic correctness issue affecting all bounded tagged ordinal types.

**Trigger**: Designing Algebra.Z<n> constructors exposed that the blanket init undermines invariant enforcement for bounded types.

## Question

Should `Tagged+Ordinal.swift`'s blanket `init(_ position: Ordinal)` exist? If not, what replaces it?

## The Blanket Init

```swift
// Tagged+Ordinal.swift (ordinal-primitives)
extension Tagged where RawValue == Ordinal, Tag: ~Copyable {
    public init(_ position: Ordinal) {
        self.init(__unchecked: (), position)
    }
}
```

This gives every `Tagged<_, Ordinal>` type a public, non-throwing, non-validating constructor.

## Types Affected

| Type | Underlying | Has invariant? | Blanket init correct? |
|---|---|---|---|
| `Index<Element>` | `Tagged<Element, Ordinal>` | No — collection checks bounds | Acceptable |
| `Ordinal.Finite<N>` | `Tagged<Finite.Bound<N>, Ordinal>` | Yes — must be in [0, N) | **Incorrect** |
| `Algebra.Z<n>` | `Tagged<Residue<n>, Ordinal>` | Yes — must be in [0, n) | **Incorrect** |
| `Bit.Index` | `Tagged<Bit, Ordinal>` | No — unbounded position | Acceptable |

## The Bug in Ordinal.Finite

`Ordinal.Finite<N>` provides a failable init with bounds checking:

```swift
// Tagged+Ordinal.Finite.swift (finite-primitives)
extension Tagged where Tag: ~Copyable {
    public init?<let N: Int>(_ position: Ordinal)
    where Tag == Finite.Bound<N>, RawValue == Ordinal {
        guard position < Cardinal(UInt(N)) else { return nil }
        self.init(__unchecked: (), position)
    }
}
```

But the blanket init from `Tagged+Ordinal.swift` also matches. Swift prefers the non-optional overload, so:

```swift
let x = Ordinal.Finite<4>(Ordinal(99))  // Silently uses blanket init. No bounds check. x == 99.
let y: Ordinal.Finite<4>? = Ordinal.Finite<4>(Ordinal(99))  // Uses failable init. y == nil.
```

The same problem would apply to `Algebra.Z<n>` with a throwing overload: Swift prefers the non-throwing inherited init when `try` is absent, silently bypassing validation.

## Call Site Analysis

37 production call sites outside ordinal-primitives use the blanket init. All are framework-internal code constructing indices from trusted sources:

| Package | Sites | Pattern |
|---|---|---|
| stack-primitives | 24 | `Stack.Index(Ordinal(UInt(_count)))` — from loop counters, arithmetic |
| buffer-primitives | 7 | `Bit.Index(Ordinal(i))` — from UInt loop variables |
| finite-primitives | 4 | `Index(Ordinal(i.position.rawValue &- 1))` — from predecessor arithmetic |
| storage-primitives | 2 | `Index(Ordinal(...))` — from pointer arithmetic |

Every call site constructs from a value already known to be valid. This is textbook `__unchecked` territory.

## Analysis

### Option A: Remove the Blanket Init

Delete `init(_ position: Ordinal)` from `Tagged+Ordinal.swift`. Each type provides its own constructor.

**For unbounded types** (`Index<Element>`, `Bit.Index`): Construction from `Ordinal` is always valid. These types can have their own `init(_ : Ordinal)` or consumers use `init(__unchecked: (), ordinal)`.

**For bounded types** (`Ordinal.Finite<N>`, `Algebra.Z<n>`): Each provides validated construction using language semantics — `throws` or failable.

**For framework-internal sites** (the 37 call sites): Migrate to `init(__unchecked: (), ordinal)` pattern. This is correct — these sites are expert code with pre-validated values.

| Criterion | Assessment |
|---|---|
| Fixes Ordinal.Finite bug | Yes |
| Enables Algebra.Z throwing init | Yes |
| Migration cost | 37 mechanical call site changes |
| Ongoing correctness | Bounded types control their own construction |

### Option B: Make the Blanket Init `__unchecked`

Change the blanket init's signature to the framework-internal `__unchecked` pattern:

```swift
extension Tagged where RawValue == Ordinal, Tag: ~Copyable {
    public init(__unchecked position: Ordinal) {
        self.init(__unchecked: (), position)
    }
}
```

Same benefits as Option A but preserves a convenience that's one character shorter than `init(__unchecked: (), ordinal)`. Marginal value — `__unchecked: ()` already exists on Tagged itself.

### Option C: Keep Blanket Init, Add Throwing Overload

Keep the blanket init. Add `init(_ : Ordinal) throws(Error)` on Algebra.Z. Accept the overload resolution behavior.

```swift
Algebra.Z<5>(someOrdinal)       // uses blanket init — unchecked
try Algebra.Z<5>(someOrdinal)   // uses throwing init — checked
```

| Criterion | Assessment |
|---|---|
| Fixes Ordinal.Finite bug | No |
| Forgetting `try` | Silently skips validation |
| API clarity | Confusing — same call, different behavior |
| Error-proneness | High — the safe path requires opt-in |

## Evaluation

| Criterion | Weight | Option A | Option B | Option C |
|---|---|---|---|---|
| Correctness for bounded types | Critical | Fixed | Fixed | Broken |
| Safe by default | Critical | Yes | Yes | No |
| `try` = validation pattern | High | Works | Works | Fragile |
| Migration effort | Low | 37 sites | 37 sites | 0 sites |
| Ongoing maintenance | Medium | Good | Good | Error-prone |

## Recommendation

**Option A: Remove the blanket init.**

### Rationale

1. **The blanket init violates the invariant enforcement pattern.** Types with bounded ordinals (`Ordinal.Finite<N>`, `Algebra.Z<n>`) cannot enforce their invariants when a non-validating constructor is inherited from below. The current state is a bug — `Ordinal.Finite<4>(Ordinal(99))` succeeds silently.

2. **All existing call sites are `__unchecked` usage.** The 37 production sites construct indices from pre-validated values (loop counters, arithmetic results, domain conversions). They should use `init(__unchecked: (), ordinal)` which is already available on `Tagged` and communicates intent.

3. **Enables the `try` = validation pattern.** Without the blanket init, `Algebra.Z<n>` can provide `init(_ : Ordinal) throws(Error)` as the single public constructor. `try` communicates validation; the compiler enforces it.

### Resulting Constructor Landscape for Algebra.Z<n>

| Constructor | Source | Use |
|---|---|---|
| `try Algebra.Z<5>(someOrdinal)` | algebra-modular-primitives | Public — bounds-checked |
| `Algebra.Z<5>(__unchecked: (), someOrdinal)` | Tagged (inherited) | Framework-internal |
| `.zero`, `.one` | ordinal-primitives / algebra-modular | Public — constants |
| `a + b`, `a - b` | algebra-modular-primitives | Public — arithmetic |

### Resulting Constructor Landscape for Ordinal.Finite<N>

The failable `init?(_ : Ordinal)` becomes the single public constructor — no more silent bypass.

### Migration

In ordinal-primitives `Tagged+Ordinal.swift`:
- Delete `init(_ position: Ordinal)`

37 call sites across 4 packages:
- Change `SomeTaggedOrdinal(ordinal)` → `SomeTaggedOrdinal(__unchecked: (), ordinal)`
- Mechanical transformation, no logic changes

### Scope

This recommendation affects ordinal-primitives (the source) and 4 downstream consumer packages. It should be implemented as a separate change from the Algebra.Z constructor additions, but is a prerequisite for them.

## References

- `swift-ordinal-primitives/Sources/Ordinal Primitives/Tagged+Ordinal.swift:16-24` — blanket init
- `swift-finite-primitives/Sources/Finite Primitives/Tagged+Ordinal.Finite.swift:9-16` — Ordinal.Finite failable init (bypassed)
- `swift-finite-primitives/Sources/Finite Primitives/Tagged+Finite.Enumerable.swift:20` — `__unchecked` pattern
- `swift-algebra-modular-primitives/Sources/Algebra Modular Primitives/Algebra.Z.swift` — Algebra.Z type
