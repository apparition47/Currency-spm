import Foundation

struct ListCurrenciesApiRequest: ApiCallRequest {
    let accessKey: String
    
    init(apiKey: String) {
        self.accessKey = apiKey
    }
    
    var path: String {
        "list"
    }
}
