// Algebra.Modular.swift

/// Modular arithmetic with runtime modulus.
///
/// Elements are `Ordinal` values in [0, modulus). The modulus is supplied
/// as a parameter to operations, enabling dynamic modular arithmetic where
/// the modulus is not known at compile time.
///
/// For compile-time modulus with type safety, use `Algebra.Z<n>`.
///
/// ## Example
///
/// ```swift
/// let modulus = try Algebra.Modular.Modulus(Cardinal(5))
/// let a = Ordinal(3)
/// let b = Ordinal(4)
/// let sum = Algebra.Modular.add(a, b, modulus: modulus)  // Ordinal(2)
/// ```
///
/// ## Design
///
/// Operations take and return `Ordinal` directly, not a wrapper type.
/// This reflects that an element of Z/nZ is simply an ordinal in [0, n);
/// the modulus is configuration, not data carried by the element.
extension Algebra {
    public enum Modular {}
}
