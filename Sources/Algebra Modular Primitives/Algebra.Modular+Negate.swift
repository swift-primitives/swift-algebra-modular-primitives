extension Algebra.Modular {

    @inlinable
    public static func negate(_ a: Ordinal, modulus: Modulus) -> Ordinal {
        guard a != .zero else { return a }
        let result = modulus.cardinal.subtract.saturating(Cardinal(a))
        return Ordinal(result)
    }
}
