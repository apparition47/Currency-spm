import XCTest
@testable import Currency

class ListCurrenciesUseCaseTest: XCTestCase {
    
    let gatewaySpy = CurrenciesGatewaySpy()
    
    var listCurrenciesUseCase: ListCurrenciesUseCaseImplementation!
    
    override func setUp() {
        super.setUp()
        listCurrenciesUseCase = ListCurrenciesUseCaseImplementation(currenciesGateway: gatewaySpy)
    }
    
    func testListSuccess() {
        // given
        let gatewayResultToBeReturned: Currencies = ["CAD": "Canadian Dollar"]
        let expectedResultToBeReturned: Result<Currencies> = Result.success(gatewayResultToBeReturned)
        gatewaySpy.listCurrenciesResultToBeReturned = expectedResultToBeReturned
        
        let completionExpectation = expectation(description: "List Expectation")
        
        // expected
        let listResultToBeReturned = Result.success([CurrencySymbol(code: "CAD", name: "Canadian Dollar")])
        listCurrenciesUseCase.list { result in
            XCTAssertEqual(listResultToBeReturned, result, "Completion didn't return the expected result")
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testListFailure() {
        // given
        let expectedGatewayResultToBeReturned: Result<Currencies> = Result.failure(LocalError(message: "Failed to list"))
        gatewaySpy.listCurrenciesResultToBeReturned = expectedGatewayResultToBeReturned
        
        let completionExpectation = expectation(description: "List Expectation")
        
        // expected
        let expectedResultToBeReturned: Result<[CurrencySymbol]> = Result.failure(LocalError(message: "Failed to list"))
        listCurrenciesUseCase.list { result in
            XCTAssertEqual(expectedResultToBeReturned, result, "Completion didn't return the expected result")
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
