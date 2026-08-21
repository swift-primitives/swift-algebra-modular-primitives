extension Tagged where Tag: Algebra.Residual, Underlying == Ordinal {

    public enum Error: Swift.Error, Hashable, Sendable {

        case bounds(Ordinal)

        case arithmetic
    }
}
