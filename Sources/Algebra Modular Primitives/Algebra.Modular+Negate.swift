// Algebra.Modular+Negate.swift

/// Modular negation operation.
extension Algebra.Modular {
    /// Computes the modular negation (additive inverse): (n - a) mod n.
    ///
    /// The result satisfies: `add(a, negate(a, modulus: m), modulus: m) == .zero`
    ///
    /// - Parameters:
    ///   - a: The ordinal to negate.
    ///   - modulus: The modulus for wrapping.
    /// - Returns: The additive inverse in [0, modulus).
    /// - Complexity: O(1)
    ///
    /// ## Example
    ///
    /// ```swift
    /// let modulus = try Algebra.Modular.Modulus(Cardinal(5))
    /// Algebra.Modular.negate(Ordinal(0), modulus: modulus)  // Ordinal(0)
    /// Algebra.Modular.negate(Ordinal(2), modulus: modulus)  // Ordinal(3)
    /// ```
    @inlinable
    public static func negate(_ a: Ordinal, modulus: Modulus) -> Ordinal {
        guard a != .zero else { return a }
        let result = modulus.cardinal.subtract.saturating(Cardinal(a))
        return Ordinal(result)
    }
}
