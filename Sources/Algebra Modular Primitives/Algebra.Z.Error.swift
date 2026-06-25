// Algebra.Z.Error.swift

extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {
    /// Errors from modular arithmetic operations.
    public enum Error: Swift.Error, Hashable, Sendable {
        /// The residue is not in [0, n).
        case bounds(Ordinal)
        /// Integer overflow during arithmetic operation.
        case arithmetic
    }
}
