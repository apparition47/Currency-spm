import XCTest
@testable import Currency

class LocalPersistCurrenciesGatewayTest: XCTestCase {
    var gateway: UserDefaultsCurrenciesGateway {
        UserDefaultsCurrenciesGateway()
    }
    
    func testSaveAndFetch() {
        // given
        let saveCompletionExpectation = expectation(description: "Save Quotes completion expectation")
        let expected = parse(jsonFile: "list", as: ListResponse.self).currencies!
        gateway.save(list: expected)
        gateway.list { result in
            // expected
            guard case let .success(quotes) = result else {
                XCTFail("Failed to load")
                return
            }
            
            if expected != quotes {
                XCTFail("Failed to decode")
            }
            
            saveCompletionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
