extension Algebra.Modular {

    @inlinable
    public static func successor(_ a: Ordinal, modulus: Modulus) -> Ordinal {
        (a + .one) % modulus.cardinal
    }
}
