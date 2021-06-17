import Foundation
@testable import Currency

class LocalPersistCurrenciesGatewaySpy: LocalPersistenceCurrenciesGateway {
    var savedList: Currencies!
    var savedLive: Quotes!
    
    var getLiveDidCalled = false
    var getListDidCalled = false
    var liveResultToBeReturned: Result<Quotes>!
    var listResultToBeReturned: Result<Currencies>!
    
    // MARK: - LocalPersistenceCurrenciesGateway
    
    func save(list: Currencies) {
        savedList = list
    }
    
    func save(live: Quotes) {
        savedLive = live
    }
    
    // MARK: - CurrenciesGateway
    
    func live(completion: @escaping LiveCurrenciesEntityGatewayCompletionHandler) {
        getLiveDidCalled = true
        completion(liveResultToBeReturned)
    }
    
    func list(completion: @escaping ListCurrenciesEntityGatewayCompletionHandler) {
        getListDidCalled = true
        completion(listResultToBeReturned)
    }
}
