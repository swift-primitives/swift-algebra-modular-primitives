// Algebra.Modular.Modulus.Error.swift

extension Algebra.Modular.Modulus {
    /// Errors thrown during modulus construction.
    public enum Error: Swift.Error, Hashable, Sendable {
        /// The modulus must be greater than zero.
        case zero
    }
}
