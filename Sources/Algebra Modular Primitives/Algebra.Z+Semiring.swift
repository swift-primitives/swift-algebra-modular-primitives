// Algebra.Z+Semiring.swift

extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {
    /// Commutative semiring witness for Z/nZ.
    ///
    /// Returns nil if the ring witness is nil (overflow for large moduli).
    @inlinable
    public static var semiring: Algebra.Semiring<Self>.Commutative? {
        ring?.semiring
    }
}
