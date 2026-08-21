extension Algebra.Modular {

    @inlinable
    public static func subtract(_ a: Ordinal, _ b: Ordinal, modulus: Modulus) -> Ordinal {

        let negB = modulus.cardinal.subtract.saturating(Cardinal(b))
        return (a + negB) % modulus.cardinal
    }
}
