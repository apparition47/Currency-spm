public struct Currency {
    let apiGateway: ApiCurrenciesGateway
    let localGateway: UserDefaultsCurrenciesGateway
    let cacheGateway: CacheCurrenciesGateway
    let useCase: ConvertCurrenciesUseCase
    
    public init(apiKey: String) {
        apiGateway = ApiCurrenciesGatewayImplementation(apiKey: apiKey)
        localGateway = UserDefaultsCurrenciesGateway()
        cacheGateway = CacheCurrenciesGateway(apiGateway: apiGateway, localPersistGateway: localGateway)
        useCase = ConvertCurrenciesUseCaseImplementation(currenciesGateway: cacheGateway)
    }
    
    /**
      Converts one currency to all others
     - returns:
        void
     - parameters:
          - amount: Currency amount to convert
          - source: ISO 4217 currency to convert from
          - completion: result of API call with array of `CurrencyRate`s
     */
    public func convert(amount: Double, source: String, completion: @escaping ([CurrencyRate]) -> Void) {
        useCase.convert(params: ConvertCurrenciesParameters(amount: amount, source: source)) { result in
            switch result {
            case let .success(currencies):
                completion(currencies)
            case let .failure(error):
                completion([])
            }
        }
    }
}
