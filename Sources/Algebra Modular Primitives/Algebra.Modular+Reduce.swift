// Algebra.Modular+Reduce.swift

/// Modular reduction operation.
extension Algebra.Modular {
    /// Reduces an ordinal to its canonical representative in [0, modulus).
    ///
    /// - Parameters:
    ///   - a: The ordinal to reduce.
    ///   - modulus: The modulus for reduction.
    /// - Returns: The canonical representative in [0, modulus).
    /// - Complexity: O(1)
    ///
    /// ## Example
    ///
    /// ```swift
    /// let modulus = try Algebra.Modular.Modulus(Cardinal(5))
    /// Algebra.Modular.reduce(Ordinal(7), modulus: modulus)   // Ordinal(2)
    /// Algebra.Modular.reduce(Ordinal(3), modulus: modulus)   // Ordinal(3)
    /// ```
    @inlinable
    public static func reduce(_ a: Ordinal, modulus: Modulus) -> Ordinal {
        a % modulus.cardinal
    }
}
