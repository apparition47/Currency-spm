import XCTest
@testable import Currency

class ConvertCurrenciesUseCaseTest: XCTestCase {
    
    let gatewaySpy = CurrenciesGatewaySpy()
    
    var convertCurrenciesUseCase: ConvertCurrenciesUseCaseImplementation!
    
    override func setUp() {
        super.setUp()
        convertCurrenciesUseCase = ConvertCurrenciesUseCaseImplementation(currenciesGateway: gatewaySpy)
    }
    
    func testConvertSuccess() {
        // given 1 USD
        let params = ConvertCurrenciesParameters(amount: 1, source: "USD")
        
        // when USD CAD rate is at 2
        let givenRate: Double = 2
        let liveResultToBeReturned: Quotes = ["USDCAD": givenRate]
        let expectedResultToBeReturned: Result<Quotes> = Result.success(liveResultToBeReturned)
        gatewaySpy.liveCurrenciesResultToBeReturned = expectedResultToBeReturned
        
        // expecting 2 CAD
        let convertedResultToBeReturned = [CurrencyRate(currPair: "USDCAD", rate: givenRate, convertedAmount: 2)]
        let expectedConvertResultToBeReturned: Result<[CurrencyRate]> = Result.success(convertedResultToBeReturned)
        let completionExpectation = expectation(description: "Convert Expectation")
        convertCurrenciesUseCase.convert(params: params) { result in
            XCTAssertEqual(expectedConvertResultToBeReturned, result, "Completion didn't return the expected result")
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
