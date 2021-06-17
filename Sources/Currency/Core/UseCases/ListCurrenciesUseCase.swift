import Foundation

typealias ListCurrenciesUseCaseCompletionHandler = (_ currencies: Result<[CurrencySymbol]>) -> Void

struct ListCurrenciesParameters {
    let source: String
}

protocol ListCurrenciesUseCase {
    func list(completion: @escaping ListCurrenciesUseCaseCompletionHandler)
}

class ListCurrenciesUseCaseImplementation: ListCurrenciesUseCase {
    
    let currenciesGateway: CurrenciesGateway
    
    init(currenciesGateway: CurrenciesGateway) {
        self.currenciesGateway = currenciesGateway
    }
    
    // MARK: - ConvertCurrenciesUseCase
    
    func list(completion: @escaping ListCurrenciesUseCaseCompletionHandler) {
        self.currenciesGateway.list { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let currencies):
                let symbols = self.parseData(currencies)
                completion(.success(symbols))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private
    
    private func parseData(_ currencies: Currencies) -> [CurrencySymbol] {
        var symbols = [CurrencySymbol]()
        for (key, value) in currencies {
            symbols.append(CurrencySymbol(code: key, name: value))
        }
        return symbols.sorted()
    }
}
