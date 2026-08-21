extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {

    @inlinable
    package static func isPrime(_ capacity: Cardinal) -> Bool {
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

    @inlinable
    package static func inverse(_ a: Ordinal, modulus: Cardinal) -> Ordinal {
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
