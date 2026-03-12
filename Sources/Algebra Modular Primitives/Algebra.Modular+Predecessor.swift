// Algebra.Modular+Predecessor.swift

/// Modular predecessor operation.
extension Algebra.Modular {
    /// Computes the modular predecessor: (a - 1 + n) mod n.
    ///
    /// - Parameters:
    ///   - a: The ordinal to retreat.
    ///   - modulus: The modulus for wrapping.
    /// - Returns: The predecessor in [0, modulus).
    /// - Complexity: O(1)
    ///
    /// ## Example
    ///
    /// ```swift
    /// let modulus = try Algebra.Modular.Modulus(Cardinal(5))
    /// Algebra.Modular.predecessor(Ordinal(0), modulus: modulus)  // Ordinal(4)
    /// Algebra.Modular.predecessor(Ordinal(3), modulus: modulus)  // Ordinal(2)
    /// ```
    @inlinable
    public static func predecessor(_ a: Ordinal, modulus: Modulus) -> Ordinal {
        // (a + (n - 1)) mod n
        let nMinusOne = modulus.cardinal.subtract.saturating(.one)
        return (a + nMinusOne) % modulus.cardinal
    }
}
