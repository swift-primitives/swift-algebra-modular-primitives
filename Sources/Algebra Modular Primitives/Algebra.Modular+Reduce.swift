extension Algebra.Modular {

    @inlinable
    public static func reduce(_ a: Ordinal, modulus: Modulus) -> Ordinal {
        a % modulus.cardinal
    }
}
