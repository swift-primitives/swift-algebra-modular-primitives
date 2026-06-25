// Algebra.Z.swift

extension Algebra {
    /// Integer residue class Z/nZ.
    ///
    /// Represents elements of the quotient ring of integers modulo n.
    /// The raw value is an ordinal in the range [0, n). The modulus n
    /// must be positive.
    ///
    /// `Z<n>` is a `Tagged<Residue<n>, Ordinal>`, gaining
    /// `Finite.Enumerable`, `Hashable`, `Comparable`, and `Sendable`
    /// for free.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let a = try Algebra.Z<5>(Ordinal(3))
    /// let b = try Algebra.Z<5>(Ordinal(4))
    /// let c = a + b                           // ordinal 2
    /// ```
    public typealias Z<let n: Int> = Tagged<Residue<n>, Ordinal>
}

// MARK: - Construction

extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {
    /// Creates a residue class element with bounds checking.
    ///
    /// - Parameter residue: The ordinal position. Must be in [0, n).
    /// - Throws: `Error.bounds` if residue >= n.
    @inlinable
    public init(_ residue: Ordinal) throws(Self.Error) {
        let n = Tag.capacity
        guard residue < n else {
            throw .bounds(residue)
        }
        self.init(_unchecked: residue)
    }
}

// MARK: - Modulus

extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {
    @inlinable
    internal static var _modulus: Algebra.Modular.Modulus {
        .init(__unchecked: Tag.capacity)
    }
}
