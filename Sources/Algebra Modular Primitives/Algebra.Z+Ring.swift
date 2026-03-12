// Algebra.Z+Ring.swift

/// Commutative ring witness for Z/nZ.
///
/// Returns nil if n <= 0 or if `(n-1)*(n-1)` overflows `UInt`. When non-nil,
/// all ring operations are total (no overflow possible).
extension Tagged where Tag: Algebra.Residual, RawValue == Ordinal {
    @inlinable
    public static var ring: Algebra.Ring<Self>.Commutative? {
        let capacity = Tag.capacity
        guard capacity > .zero else { return nil }
        let maxResidue = capacity.subtract.saturating(.one)
        let (_, overflow) = maxResidue.rawValue.multipliedReportingOverflow(by: maxResidue.rawValue)
        guard !overflow else { return nil }
        return .init(ring: .init(
            additive: .init(group: .init(
                identity: .zero,
                combining: { $0 + $1 },
                inverting: { $0.negated }
            )),
            multiplicative: .init(
                identity: .one,
                combining: { lhs, rhs in try! lhs * rhs }
            )
        ))
    }
}
