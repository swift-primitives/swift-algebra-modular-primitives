extension Algebra.Modular {

    @inlinable
    public static func add(_ a: Ordinal, _ b: Ordinal, modulus: Modulus) -> Ordinal {
        (a + Cardinal(b)) % modulus.cardinal
    }
}
