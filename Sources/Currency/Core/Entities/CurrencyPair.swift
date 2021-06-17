import Foundation

public struct CurrencyPair {
    public let from: String
    public let to: String
}

extension CurrencyPair: CustomStringConvertible {
    public var description: String {
        "\(from) -> \(to)"
    }
}

extension CurrencyPair: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = CurrencyPair(from: String(value.prefix(3)), to: String(value.suffix(3)))
    }
}
