import Foundation

typealias ConvertCurrenciesUseCaseCompletionHandler = (_ currencies: Result<[CurrencyRate]>) -> Void

struct ConvertCurrenciesParameters {
    let amount: Double
    let source: String
}

protocol ConvertCurrenciesUseCase {
    func convert(params: ConvertCurrenciesParameters, completion: @escaping ConvertCurrenciesUseCaseCompletionHandler)
}

class ConvertCurrenciesUseCaseImplementation: ConvertCurrenciesUseCase {
    
    let currenciesGateway: CurrenciesGateway
    
    init(currenciesGateway: CurrenciesGateway) {
        self.currenciesGateway = currenciesGateway
    }
    
    // MARK: - ConvertCurrenciesUseCase
    
    func convert(params: ConvertCurrenciesParameters, completion: @escaping ConvertCurrenciesUseCaseCompletionHandler) {
        self.currenciesGateway.live { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let quotes):
                let converted = self.convert(quotes, amount: params.amount, toCurrencyCode: params.source)
                completion(.success(converted))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Helpers
    
    // local double conversion: convert to USD then to target curr because of API free plan
    private func convert(_ quotes: Quotes, amount: Double, toCurrencyCode: String) -> [CurrencyRate] {
        let usdAmt: Double = 1 / (quotes["USD\(toCurrencyCode)"] ?? 1)
        var converted = [CurrencyRate]()
        for (currCodeTarget, usdTargetRate) in quotes {
            let targetRate = usdAmt * usdTargetRate
            let pair = CurrencyPair(from: toCurrencyCode, to: "\(currCodeTarget.suffix(3))")
            converted.append(CurrencyRate(
                currPair: pair,
                rate: targetRate,
                convertedAmount: targetRate * amount
            ))
        }
        return converted.sorted {$0.currPair.to < $1.currPair.to}
    }
}
