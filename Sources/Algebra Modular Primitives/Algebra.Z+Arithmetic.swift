// Algebra.Z+Arithmetic.swift

extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {
    /// Multiplicative identity / generator of Z/nZ.
    @inlinable
    public static var one: Self {
        Self(_unchecked: 1 % Tag.capacity)
    }

    /// Additive inverse.
    @inlinable
    public var negated: Self {
        map { Algebra.Modular.negate($0, modulus: Self._modulus) }
    }
}

// MARK: - Addition

extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {
    /// Returns the sum of two residue classes modulo n.
    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        lhs.map { Algebra.Modular.add($0, rhs.underlying, modulus: _modulus) }
    }

    /// Adds a residue class into this one modulo n.
    @inlinable
    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
}

// MARK: - Subtraction

extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {
    /// Returns the difference of two residue classes modulo n.
    @inlinable
    public static func - (lhs: Self, rhs: Self) -> Self {
        lhs.map { Algebra.Modular.subtract($0, rhs.underlying, modulus: _modulus) }
    }

    /// Subtracts a residue class from this one modulo n.
    @inlinable
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }
}

// MARK: - Negation

extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {
    /// Returns the additive inverse of a residue class.
    @inlinable
    public static prefix func - (value: Self) -> Self {
        value.negated
    }
}

// MARK: - Multiplication

extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {
    /// Returns the product of two residue classes modulo n.
    ///
    /// - Throws: `Error.arithmetic` if the integer product overflows `UInt`.
    @inlinable
    public static func * (lhs: Self, rhs: Self) throws(Self.Error) -> Self {
        // `Tagged<Tag, Ordinal>` where `Tag: Algebra.Residual` is itself the
        // modular-arithmetic wrapper; reaching through `.rawValue` into stdlib
        // `UInt` overflow-aware multiplication is the typed-system bottom-out.
        let (product, overflow) = lhs.ordinal.rawValue.multipliedReportingOverflow(by: rhs.ordinal.rawValue)
        guard !overflow else { throw .arithmetic }
        return Self(_unchecked: Ordinal(product % Tag.capacity.rawValue))
    }

    /// Multiplies this residue class by another modulo n, in place.
    ///
    /// - Throws: `Error.arithmetic` if the integer product overflows `UInt`.
    @inlinable
    public static func *= (lhs: inout Self, rhs: Self) throws(Self.Error) {
        lhs = try lhs * rhs
    }
}
