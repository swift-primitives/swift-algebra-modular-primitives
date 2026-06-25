// Algebra.Residual.swift

extension Algebra {
    /// Marker protocol for tags representing residue classes Z/nZ.
    ///
    /// Extends `Finite.Capacity` to carry the modulus as `capacity`.
    /// Used to scope modular arithmetic extensions to `Tagged` types
    /// without leaking to other `Tagged<*, Ordinal>` types like `Ordinal.Finite`.
    public protocol Residual: Finite.Capacity {}
}
