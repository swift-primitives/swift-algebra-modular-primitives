// Algebra.Modular+Successor.swift

/// Modular successor operation.
extension Algebra.Modular {
    /// Computes the modular successor: (a + 1) mod n.
    ///
    /// - Parameters:
    ///   - a: The ordinal to advance.
    ///   - modulus: The modulus for wrapping.
    /// - Returns: The successor in [0, modulus).
    /// - Complexity: O(1)
    ///
    /// ## Example
    ///
    /// ```swift
    /// let modulus = try Algebra.Modular.Modulus(Cardinal(5))
    /// Algebra.Modular.successor(Ordinal(4), modulus: modulus)  // Ordinal(0)
    /// Algebra.Modular.successor(Ordinal(2), modulus: modulus)  // Ordinal(3)
    /// ```
    @inlinable
    public static func successor(_ a: Ordinal, modulus: Modulus) -> Ordinal {
        (a + .one) % modulus.cardinal
    }
}
