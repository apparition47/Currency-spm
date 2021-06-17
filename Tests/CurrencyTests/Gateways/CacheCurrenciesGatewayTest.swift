import XCTest
@testable import Currency

class CacheCurrenciesGatewayTest: XCTestCase {
    var apiGatewaySpy = ApiCurrenciesGatewaySpy()
    var localGatewaySpy = LocalPersistCurrenciesGatewaySpy()
    var cacheGateway: CacheCurrenciesGateway!
    
    override func setUp() {
        super.setUp()
        cacheGateway = CacheCurrenciesGateway(apiGateway: apiGatewaySpy, localPersistGateway: localGatewaySpy)
    }
    
    // MARK: - Tests
    
    func testListCacheGetSuccess() {
        // given
        let listToReturn = parse(jsonFile: "list", as: ListResponse.self).currencies!
        let expectedResultToReturn: Result<Currencies> = .success(listToReturn)
        
        apiGatewaySpy.listResultToBeReturned = expectedResultToReturn
        let completionExpectation = expectation(description: "Get List completion expectation")
        localGatewaySpy.listResultToBeReturned = expectedResultToReturn
        
        // expected
        cacheGateway.list { res in
            XCTAssertEqual(expectedResultToReturn, res, "The expected result wasn't returned")
            XCTAssertEqual(listToReturn, self.localGatewaySpy.savedList, "list wasn't persisted")
            
            completionExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testListCacheGetFailure() {
        // given
        let expectedResultToReturn: Result<Currencies> = .failure(LocalError(message: "Error occurred"))
        
        apiGatewaySpy.listResultToBeReturned = expectedResultToReturn
        localGatewaySpy.listResultToBeReturned = expectedResultToReturn
        let completionExpectation = expectation(description: "Get List completion expectation")
        
        // expected
        cacheGateway.list { res in
            XCTAssertEqual(expectedResultToReturn, res, "The expected result wasn't returned")
            XCTAssertTrue(self.localGatewaySpy.getListDidCalled, "get list wasn't called")
            
            completionExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
