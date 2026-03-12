// Algebra.Modular.Modulus.Error.swift

/// Errors thrown during modulus construction.
extension Algebra.Modular.Modulus {
    public enum Error: Swift.Error, Hashable, Sendable {
        /// The modulus must be greater than zero.
        case zero
    }
}
