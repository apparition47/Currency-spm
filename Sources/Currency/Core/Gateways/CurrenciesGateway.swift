import Foundation

typealias LiveCurrenciesEntityGatewayCompletionHandler = (_ quotes: Result<Quotes>) -> Void
typealias ListCurrenciesEntityGatewayCompletionHandler = (_ currencies: Result<Currencies>) -> Void

protocol CurrenciesGateway {
    func live(completion: @escaping LiveCurrenciesEntityGatewayCompletionHandler)
    func list(completion: @escaping ListCurrenciesEntityGatewayCompletionHandler)
}
