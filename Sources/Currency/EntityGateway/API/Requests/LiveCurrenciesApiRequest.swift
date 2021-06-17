import Foundation

struct LiveCurrenciesApiRequest: ApiCallRequest {
    let accessKey: String
    
    init(apiKey: String) {
        self.accessKey = apiKey
    }
    
    var path: String {
        "live"
    }
}
