extension Algebra {

    public enum Residue<let n: Int>: Residual, Hashable, Sendable {
    }
}

extension Algebra.Residue {

    @inlinable
    public static var capacity: Cardinal { .init(integerLiteral: UInt(n)) }
}
