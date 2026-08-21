extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {

    @inlinable
    public static var one: Self {
        Self(_unchecked: 1 % Tag.capacity)
    }

    @inlinable
    public var negated: Self {
        map { Algebra.Modular.negate($0, modulus: Self._modulus) }
    }
}

extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {

    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        lhs.map { Algebra.Modular.add($0, rhs.underlying, modulus: _modulus) }
    }

    @inlinable
    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
}

extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {

    @inlinable
    public static func - (lhs: Self, rhs: Self) -> Self {
        lhs.map { Algebra.Modular.subtract($0, rhs.underlying, modulus: _modulus) }
    }

    @inlinable
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }
}

extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {

    @inlinable
    public static prefix func - (value: Self) -> Self {
        value.negated
    }
}

extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {

    @inlinable
    public static func * (lhs: Self, rhs: Self) throws(Self.Error) -> Self {

        let (product, overflow) = lhs.ordinal.rawValue.multipliedReportingOverflow(
            by: rhs.ordinal.rawValue
        )
        guard !overflow else { throw .arithmetic }
        return Self(_unchecked: Ordinal(product % Tag.capacity.rawValue))
    }

    @inlinable
    public static func *= (lhs: inout Self, rhs: Self) throws(Self.Error) {
        lhs = try lhs * rhs
    }
}
