// Algebra Modular Primitives Test Support
// Provides test-only conveniences for algebra-modular-primitives.

public import Algebra_Modular_Primitives

// MARK: - ExpressibleByIntegerLiteral for Algebra.Z

/// Test-only conformance allowing integer literals for residue class elements.
///
/// This conformance uses a precondition for bounds checking, which is
/// acceptable for tests where invalid indices indicate test bugs.
///
/// - Warning: This is test-only. Production code should use the throwing
///   initializers `Algebra.Z<N>(Int)` or `Algebra.Z<N>(wrapping:)`.
extension Tagged: @retroactive ExpressibleByIntegerLiteral
where Tag: Algebra.Residual, RawValue == Ordinal {
    @inlinable
    @_disfavoredOverload
    public init(integerLiteral value: Int) {
        let capacity = Tag.capacity
        precondition(capacity > .zero, "Invalid modulus for Z<\(capacity)>")
        precondition(value >= 0 && Ordinal(UInt(value)) < capacity, "Index \(value) out of bounds for Z<\(capacity)>")
        self.init(__unchecked: (), Ordinal(UInt(value)))
    }
}
