import Foundation
@testable import Currency

class ListCurrenciesUseCaseSpy: ListCurrenciesUseCase {
    var resultToBeReturned: Result<[CurrencySymbol]>!
    
    func list(completion: @escaping ListCurrenciesUseCaseCompletionHandler) {
        completion(resultToBeReturned)
    }
}
