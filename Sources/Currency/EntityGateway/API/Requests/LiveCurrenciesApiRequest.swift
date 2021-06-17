import Foundation

struct LiveCurrenciesApiRequest: ApiCallRequest {
    private(set) var _accessKey: String
    
    init(apiKey: String) {
        _accessKey = apiKey
    }
    
    var accessKey: String {
        _accessKey
    }
    
    var path: String {
        "live"
    }
}
