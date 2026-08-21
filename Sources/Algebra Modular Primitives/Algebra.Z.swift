extension Algebra {

    public typealias Z<let n: Int> = Tagged<Residue<n>, Ordinal>
}

extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {

    @inlinable
    public init(_ residue: Ordinal) throws(Self.Error) {
        let n = Tag.capacity
        guard residue < n else {
            throw .bounds(residue)
        }
        self.init(_unchecked: residue)
    }
}

extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {
    @inlinable
    package static var _modulus: Algebra.Modular.Modulus {

        .init(__unchecked: Tag.capacity)
    }
}
