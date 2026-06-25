# Algebra Modular Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Integer modular arithmetic for Swift — the residue class Z/nZ as a compile-time-tagged `Algebra.Z<n>` and as a runtime `Algebra.Modular` namespace, with commutative ring, semiring, and field witnesses.

---

## Quick Start

`Algebra.Z<n>` is the integers modulo `n` with the modulus carried in the type: it is a `Tagged<Algebra.Residue<n>, Ordinal>`, so it gains `Finite.Enumerable`, `Hashable`, `Comparable`, and `Sendable` for free, and construction is bounds-checked against `[0, n)`.

```swift
import Algebra_Modular_Primitives

// Z/5Z: residue classes with the modulus fixed by the type.
let a = try Algebra.Z<5>(Ordinal(3))
let b = try Algebra.Z<5>(Ordinal(4))

let sum = a + b           // 3 + 4 ≡ 2 (mod 5)
let difference = a - b    // 3 - 4 ≡ 4 (mod 5)
let inverse = -a          // additive inverse ≡ 2 (mod 5)
let product = try a * b   // 3 · 4 ≡ 2 (mod 5); throws only on UInt overflow
```

Because 5 is prime, Z/5Z is a *field*: the `field()` witness exposes the multiplicative reciprocal of every nonzero element. The `ring` and `semiring` witnesses are available for any positive modulus.

```swift
import Algebra_Modular_Primitives

if let field = Algebra.Z<5>.field() {
    let reciprocal = try field.reciprocal(b)   // 4⁻¹ ≡ 4 (mod 5)
}

let commutativeRing = Algebra.Z<6>.ring        // non-nil: Z/6Z is a ring, not a field
```

When the modulus is only known at runtime, reach for `Algebra.Modular`. Elements are plain `Ordinal` values and the validated `Modulus` is passed to each operation, so the modulus is configuration rather than data carried by the element.

```swift
import Algebra_Modular_Primitives

let modulus = try Algebra.Modular.Modulus(Cardinal(7))

Algebra.Modular.add(Ordinal(5), Ordinal(4), modulus: modulus)        // 9 ≡ 2 (mod 7)
Algebra.Modular.subtract(Ordinal(1), Ordinal(3), modulus: modulus)   // -2 ≡ 5 (mod 7)
Algebra.Modular.successor(Ordinal(6), modulus: modulus)              // 0 (wraps)
Algebra.Modular.negate(Ordinal(2), modulus: modulus)                 // 5
```

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-algebra-modular-primitives.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Algebra Modular Primitives", package: "swift-algebra-modular-primitives"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

One library product, building on the `Algebra.Field` algebra witnesses and the `Finite` / `Ordinal` / `Cardinal` primitives.

| Product | Target | Purpose |
|---------|--------|---------|
| `Algebra Modular Primitives` | `Sources/Algebra Modular Primitives/` | The compile-time residue class `Algebra.Z<n>` and its arithmetic, the runtime `Algebra.Modular` namespace and its validated `Modulus`, and the `ring` / `semiring` / `field()` algebraic-structure witnesses. |
| `Algebra Modular Primitives Test Support` | `Tests/Support/` | Re-exports the main target for test consumers. |

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
