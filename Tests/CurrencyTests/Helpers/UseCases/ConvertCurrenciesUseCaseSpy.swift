import Foundation
@testable import Currency

class ConvertCurrenciesUseCaseSpy: ConvertCurrenciesUseCase {
    
    var resultToBeReturned: Result<[CurrencyRate]>!
    
    func convert(params: ConvertCurrenciesParameters, completion: @escaping ConvertCurrenciesUseCaseCompletionHandler) {
        completion(resultToBeReturned)
    }
}
