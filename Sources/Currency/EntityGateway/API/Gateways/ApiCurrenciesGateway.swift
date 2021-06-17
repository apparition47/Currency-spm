import Foundation


protocol ApiCurrenciesGateway: CurrenciesGateway {
    var apiKey: String { get }
}

class ApiCurrenciesGatewayImplementation: ApiCurrenciesGateway {
    
    private(set) var _apiKey: String

    init(apiKey: String) {
        self._apiKey = apiKey
    }
    
    // MARK: - ApiCurrenciesGateway
    
    var apiKey: String {
        _apiKey
    }
    
    // MARK: - CurrenciesGateway
    
    func live(completion: @escaping LiveCurrenciesEntityGatewayCompletionHandler) {
        let req = LiveCurrenciesApiRequest(apiKey: apiKey)
        APIManager.execute(request: req, completion: { (result: LiveResponse?, err: Error?) in
            if let err = err {
                completion(.failure(err))
                return
            }
            
            guard let result = result else {
                let err = LocalError(message: "Unknown error")
                completion(.failure(err))
                return
            }
            
            guard result.success, let quotes = result.quotes else {
                let err = LocalError(message: result.error?.info ?? "API error")
                completion(.failure(err))
                return
            }
            completion(.success(quotes))
        })
    }
    
    func list(completion: @escaping ListCurrenciesEntityGatewayCompletionHandler) {
        let req = ListCurrenciesApiRequest(apiKey: apiKey)
        APIManager.execute(request: req, completion: { (result: ListResponse?, err: Error?) in
            if let err = err {
                completion(.failure(err))
                return
            }
            
            guard let result = result else {
                let err = LocalError(message: "Unknown error")
                completion(.failure(err))
                return
            }
            
            guard result.success, let currencies = result.currencies else {
                let err = LocalError(message: result.error?.info ?? "API error")
                completion(.failure(err))
                return
            }
            completion(.success(currencies))
        })
    }
    
}
