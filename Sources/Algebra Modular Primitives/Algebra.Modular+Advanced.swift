// Algebra.Modular+Advanced.swift

public import Carrier_Primitives
public import Affine_Primitives

/// Modular advancement by signed vector.
extension Algebra.Modular {
    /// Advances an ordinal by a signed vector with modular wrapping.
    ///
    /// Handles both positive and negative displacements, wrapping as needed.
    ///
    /// - Parameters:
    ///   - a: The ordinal to advance.
    ///   - vector: The signed displacement.
    ///   - modulus: The modulus for wrapping.
    /// - Returns: The advanced ordinal in [0, modulus).
    /// - Complexity: O(1)
    ///
    /// ## Example
    ///
    /// ```swift
    /// let modulus = try Algebra.Modular.Modulus(Cardinal(5))
    /// Algebra.Modular.advanced(Ordinal(2), by: Affine.Discrete.Vector(4), modulus: modulus)   // Ordinal(1)
    /// Algebra.Modular.advanced(Ordinal(2), by: Affine.Discrete.Vector(-3), modulus: modulus)  // Ordinal(4)
    /// ```
    @inlinable
    public static func advanced(_ a: Ordinal, by vector: some Carrier<Affine.Discrete.Vector>, modulus: Modulus) -> Ordinal {
        let n = Int(bitPattern: modulus.cardinal.rawValue)
        return (a + Cardinal(UInt(((vector.vector.rawValue % n) + n) % n))) % modulus.cardinal
    }
}
