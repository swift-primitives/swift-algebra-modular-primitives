// Algebra.Residue.swift

extension Algebra {
    /// Phantom tag carrying the modulus for Z/nZ.
    ///
    /// Conforms to `Residual` (and therefore `Finite.Capacity`), providing
    /// `capacity == n`. This enables `Tagged<Residue<n>, Ordinal>` to
    /// automatically gain `Finite.Enumerable` conformance.
    public enum Residue<let n: Int>: Residual, Hashable, Sendable {
        /// The modulus `n`, exposed as the cardinal capacity of the residue class.
        @inlinable
        public static var capacity: Cardinal { .init(integerLiteral: UInt(n)) }
    }
}
