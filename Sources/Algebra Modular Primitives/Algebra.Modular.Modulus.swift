// Algebra.Modular.Modulus.swift

/// A validated positive modulus for runtime modular arithmetic.
///
/// Encapsulates the invariant that a modulus must be greater than zero.
/// Use this type with `Algebra.Modular` operations to ensure valid
/// modular arithmetic.
///
/// ## Example
///
/// ```swift
/// let modulus = try Algebra.Modular.Modulus(Cardinal(5))
/// let successor = Algebra.Modular.successor(Ordinal(4), modulus: modulus)  // 0
/// ```
extension Algebra.Modular {
    public struct Modulus: Hashable, Comparable, Sendable {
        /// The positive modulus value.
        public let cardinal: Cardinal

        /// Creates a modulus from a cardinal value.
        ///
        /// - Parameter cardinal: The modulus value (must be > 0).
        /// - Throws: `Error.zero` if the value is zero.
        @inlinable
        public init(_ cardinal: Cardinal) throws(Error) {
            guard cardinal > .zero else { throw .zero }
            self.cardinal = cardinal
        }

        /// Creates a modulus without validation.
        ///
        /// - Parameter cardinal: Must be > 0.
        /// - Warning: No validation is performed. Use only when the value
        ///   is known to be positive.
        @inlinable
        public init(__unchecked cardinal: Cardinal) {
            self.cardinal = cardinal
        }

        // MARK: - Comparable

        @inlinable
        public static func < (lhs: Self, rhs: Self) -> Bool {
            lhs.cardinal < rhs.cardinal
        }
    }
}
