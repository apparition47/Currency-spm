import Foundation

struct CurrencySymbol {
   let code: String
   let name: String
}

extension CurrencySymbol: Comparable {
    static func < (lhs: CurrencySymbol, rhs: CurrencySymbol) -> Bool {
        return lhs.code < rhs.code
    }
}
