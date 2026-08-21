extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {

    @inlinable
    public static var semiring: Algebra.Semiring<Self>.Commutative? {
        ring?.semiring
    }
}
