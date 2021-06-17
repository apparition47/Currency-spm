import Foundation
@testable import Currency

class ApiCurrenciesGatewaySpy: ApiCurrenciesGateway {
    var apiKey: String {
        "fake-key"
    }
    
    var liveResultToBeReturned: Result<Quotes>!
    var listResultToBeReturned: Result<Currencies>!
    
    func live(completion: @escaping LiveCurrenciesEntityGatewayCompletionHandler) {
        completion(liveResultToBeReturned)
    }
    
    func list(completion: @escaping ListCurrenciesEntityGatewayCompletionHandler) {
        completion(listResultToBeReturned)
    }
}
