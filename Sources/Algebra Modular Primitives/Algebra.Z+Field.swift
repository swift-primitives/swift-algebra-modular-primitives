// Algebra.Z+Field.swift

/// Field witness for Z/pZ when p is prime.
///
/// Returns nil when n is not prime or when `(n-1)*(n-1)` overflows `UInt`.
/// Reciprocal throws `Algebra.Field<Self>.Error.nonInvertible` for zero.
extension Tagged where Tag: Algebra.Residual, RawValue == Ordinal {
    @inlinable
    public static func field() -> Algebra.Field<Self>? {
        let capacity = Tag.capacity
        guard capacity > .one else { return nil }
        guard isPrime(capacity) else { return nil }
        guard let ring = ring else { return nil }
        return .init(
            additive: ring.ring.additive,
            multiplicative: .init(monoid: ring.ring.multiplicative),
            reciprocal: { element throws(Algebra.Field<Self>.Error) in
                guard element != .zero else { throw .nonInvertible }
                return Self(__unchecked: (), inverse(element.rawValue, modulus: capacity))
            }
        )
    }
}
