// Algebra.Modular+Subtract.swift

/// Modular subtraction operation.
extension Algebra.Modular {
    /// Computes modular subtraction: (a - b + n) mod n.
    ///
    /// - Parameters:
    ///   - a: The minuend.
    ///   - b: The subtrahend.
    ///   - modulus: The modulus for wrapping.
    /// - Returns: The difference in [0, modulus).
    /// - Complexity: O(1)
    ///
    /// ## Example
    ///
    /// ```swift
    /// let modulus = try Algebra.Modular.Modulus(Cardinal(5))
    /// Algebra.Modular.subtract(Ordinal(1), Ordinal(3), modulus: modulus)  // Ordinal(3)
    /// ```
    @inlinable
    public static func subtract(_ a: Ordinal, _ b: Ordinal, modulus: Modulus) -> Ordinal {
        // (a - b + n) mod n = (a + (n - b)) mod n
        let negB = modulus.cardinal.subtract.saturating(Cardinal(b))
        return (a + negB) % modulus.cardinal
    }
}
