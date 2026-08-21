extension Algebra.Modular {

    @inlinable
    public static func predecessor(_ a: Ordinal, modulus: Modulus) -> Ordinal {

        let nMinusOne = modulus.cardinal.subtract.saturating(.one)
        return (a + nMinusOne) % modulus.cardinal
    }
}
