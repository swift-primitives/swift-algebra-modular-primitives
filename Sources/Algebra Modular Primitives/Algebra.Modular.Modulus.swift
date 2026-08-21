extension Algebra.Modular {

    public struct Modulus: Hashable, Comparable, Sendable {

        public let cardinal: Cardinal

        @inlinable
        public init(_ cardinal: Cardinal) throws(Self.Error) {
            guard cardinal > .zero else { throw .zero }
            self.cardinal = cardinal
        }

        @inlinable
        public init(__unchecked cardinal: Cardinal) {
            self.cardinal = cardinal
        }
    }
}

extension Algebra.Modular.Modulus {

    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.cardinal < rhs.cardinal
    }
}
