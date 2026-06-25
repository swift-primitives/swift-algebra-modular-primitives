// Algebra.Z+Primality.swift

extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {
    /// Tests whether a positive integer is prime via trial division.
    ///
    /// Uses `i <= n / i` loop condition to avoid overflow in `i * i`.
    /// Time complexity: O(sqrt(n)).
    @inlinable
    internal static func isPrime(_ capacity: Cardinal) -> Bool {
        let n = Int(bitPattern: capacity)
        guard n >= 2 else { return false }
        guard n >= 4 else { return true }
        guard !n.isMultiple(of: 2) else { return false }
        var i = 3
        while i <= n / i {
            if n.isMultiple(of: i) { return false }
            i += 2
        }
        return true
    }

    /// Computes the modular inverse of `a` modulo `modulus` via extended Euclidean algorithm.
    ///
    /// Returns the unique `x` in [0, modulus) such that `a * x ≡ 1 (mod modulus)`.
    /// Precondition: `gcd(a, modulus) == 1` and `modulus > 1`.
    /// Intermediate values are bounded by the modulus, so no overflow risk.
    @inlinable
    internal static func inverse(_ a: Ordinal, modulus: Cardinal) -> Ordinal {
        let m = Int(bitPattern: modulus)
        var oldR = Int(bitPattern: a)
        var r = m
        var oldS = 1
        var s = 0

        while r != 0 {
            let q = oldR / r
            let tempR = r
            r = oldR - q * r
            oldR = tempR
            let tempS = s
            s = oldS - q * s
            oldS = tempS
        }

        let result = oldS % m
        return Ordinal(UInt(result < 0 ? result + m : result))
    }
}
