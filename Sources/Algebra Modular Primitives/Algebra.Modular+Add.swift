// Algebra.Modular+Add.swift

/// Modular addition operation.
extension Algebra.Modular {
    /// Computes modular addition: (a + b) mod n.
    ///
    /// - Parameters:
    ///   - a: First operand.
    ///   - b: Second operand.
    ///   - modulus: The modulus for wrapping.
    /// - Returns: The sum in [0, modulus).
    /// - Complexity: O(1)
    ///
    /// ## Example
    ///
    /// ```swift
    /// let modulus = try Algebra.Modular.Modulus(Cardinal(5))
    /// Algebra.Modular.add(Ordinal(3), Ordinal(4), modulus: modulus)  // Ordinal(2)
    /// ```
    @inlinable
    public static func add(_ a: Ordinal, _ b: Ordinal, modulus: Modulus) -> Ordinal {
        (a + Cardinal(b)) % modulus.cardinal
    }
}
