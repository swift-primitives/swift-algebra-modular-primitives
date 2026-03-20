// Algebra.Z+Arithmetic.swift

extension Tagged where Tag: Algebra.Residual, RawValue == Ordinal {
    /// Multiplicative identity / generator of Z/nZ.
    @inlinable
    public static var one: Self {
        Self(__unchecked: (), 1 % Tag.capacity)
    }

    /// Additive inverse.
    @inlinable
    public var negated: Self {
        map { Algebra.Modular.negate($0, modulus: Self._modulus) }
    }
}

// MARK: - Addition

extension Tagged where Tag: Algebra.Residual, RawValue == Ordinal {
    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        lhs.map { Algebra.Modular.add($0, rhs.rawValue, modulus: _modulus) }
    }

    @inlinable
    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
}

// MARK: - Subtraction

extension Tagged where Tag: Algebra.Residual, RawValue == Ordinal {
    @inlinable
    public static func - (lhs: Self, rhs: Self) -> Self {
        lhs.map { Algebra.Modular.subtract($0, rhs.rawValue, modulus: _modulus) }
    }

    @inlinable
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }
}

// MARK: - Negation

extension Tagged where Tag: Algebra.Residual, RawValue == Ordinal {
    @inlinable
    public static prefix func - (value: Self) -> Self {
        value.negated
    }
}

// MARK: - Multiplication

extension Tagged where Tag: Algebra.Residual, RawValue == Ordinal {
    @inlinable
    public static func * (lhs: Self, rhs: Self) throws(Error) -> Self {
        let (product, overflow) = lhs.ordinal.rawValue.multipliedReportingOverflow(by: rhs.ordinal.rawValue)
        guard !overflow else { throw .arithmetic }
        return Self(__unchecked: (), Ordinal(product % Tag.capacity.rawValue))
    }

    @inlinable
    public static func *= (lhs: inout Self, rhs: Self) throws(Error) {
        lhs = try lhs * rhs
    }
}
