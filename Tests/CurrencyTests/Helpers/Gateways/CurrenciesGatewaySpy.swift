import Foundation
@testable import Currency

class CurrenciesGatewaySpy: CurrenciesGateway {
    var liveCurrenciesResultToBeReturned: Result<Quotes>!
    var listCurrenciesResultToBeReturned: Result<Currencies>!
    
    func live(completion: @escaping LiveCurrenciesEntityGatewayCompletionHandler) {
        completion(liveCurrenciesResultToBeReturned)
    }
    
    func list(completion: @escaping ListCurrenciesEntityGatewayCompletionHandler) {
        completion(listCurrenciesResultToBeReturned)
    }
}
