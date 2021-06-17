import Foundation

private let UserDefaultsLiveKey = "UserDefaultsLiveKey"
private let UserDefaultsListKey = "UserDefaultsListKey"

protocol LocalPersistenceCurrenciesGateway: CurrenciesGateway {
    func save(list: Currencies)
    func save(live: Quotes)
}

class UserDefaultsCurrenciesGateway: LocalPersistenceCurrenciesGateway {

    // MARK: - ApiCurrenciesGateway
    
    func live(completion: @escaping LiveCurrenciesEntityGatewayCompletionHandler) {
        if let data = UserDefaults.standard.value(forKey: UserDefaultsLiveKey) as? Data,
            let obj = try? ApiLayerJSONDecoder().decode(Quotes.self, from: data) {
            completion(.success(obj))
        } else {
            completion(.failure(LocalError(message: "\(UserDefaultsLiveKey) not found")))
        }
    }
    
    func list(completion: @escaping ListCurrenciesEntityGatewayCompletionHandler) {
        if let data = UserDefaults.standard.value(forKey: UserDefaultsListKey) as? Data,
            let obj = try? ApiLayerJSONDecoder().decode(Currencies.self, from: data) {
            completion(.success(obj))
        } else {
            completion(.failure(LocalError(message: "\(UserDefaultsListKey) not found")))
        }
    }
    
    // MARK: - LocalPersistenceCurrenciesGateway
    
    func save(list: Currencies) {
        if let data = try? JSONEncoder().encode(list) {
            UserDefaults.standard.set(data, forKey: UserDefaultsListKey)
        }
    }
    
    func save(live: Quotes) {
        if let data = try? JSONEncoder().encode(live) {
            UserDefaults.standard.set(data, forKey: UserDefaultsLiveKey)
        }
    }
}
