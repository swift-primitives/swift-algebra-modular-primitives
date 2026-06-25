// Algebra.Z+Field.swift

extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {
    /// Field witness for Z/pZ when p is prime.
    ///
    /// Returns nil when n is not prime or when `(n-1)*(n-1)` overflows `UInt`.
    /// Reciprocal throws `Algebra.Field<Self>.Error.nonInvertible` for zero.
    @inlinable
    public static func field() -> Algebra.Field<Self>? {
        let capacity = Tag.capacity
        guard capacity > .one else { return nil }
        guard isPrime(capacity) else { return nil }
        guard let ring else { return nil }
        return .init(
            additive: ring.ring.additive,
            multiplicative: .init(monoid: ring.ring.multiplicative),
            reciprocal: { element throws(Algebra.Field<Self>.Error) in
                guard element != .zero else { throw .nonInvertible }
                return Self(_unchecked: inverse(element.underlying, modulus: capacity))
            }
        )
    }
}
