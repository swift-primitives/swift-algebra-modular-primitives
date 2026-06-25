// Algebra.Z+Ring.swift

extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {
    /// Commutative ring witness for Z/nZ.
    ///
    /// Returns nil if n <= 0 or if `(n-1)*(n-1)` overflows `UInt`. When non-nil,
    /// all ring operations are total (no overflow possible).
    @inlinable
    public static var ring: Algebra.Ring<Self>.Commutative? {
        let capacity = Tag.capacity
        guard capacity > .zero else { return nil }
        let maxResidue = capacity.subtract.saturating(.one)
        let raw = maxResidue.rawValue
        let (_, overflow) = raw.multipliedReportingOverflow(by: raw)
        guard !overflow else { return nil }
        return .init(
            ring: .init(
                additive: .init(
                    group: .init(
                        identity: .zero,
                        combining: { $0 + $1 },
                        inverting: { $0.negated }
                    )
                ),
                multiplicative: .init(
                    identity: .one,
                    combining: { lhs, rhs in
                        // `ring` is non-nil only when `(n - 1) * (n - 1)` fits
                        // in `UInt`, so this product never overflows and `*`
                        // never throws here.
                        do throws(Self.Error) {
                            return try lhs * rhs
                        } catch {
                            fatalError("unreachable: modular product overflow in a validated ring")
                        }
                    }
                )
            )
        )
    }
}
