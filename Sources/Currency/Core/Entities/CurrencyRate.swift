import Foundation

public struct CurrencyRate {
    public let currPair: CurrencyPair
    public let rate: Double
    public let convertedAmount: Double
    
    public var description: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currPair.to
        formatter.maximumFractionDigits = 2

        let number = NSNumber(value: convertedAmount)
        return formatter.string(from: number)!
    }
}
