import Foundation

protocol ApiCallRequest {
    var baseURL: String { get }
    var params: [String: Any] { get }
    var path: String { get }
    var accessKey: String { get }
}

extension ApiCallRequest {
    var baseURL: String {
        "http://api.currencylayer.com" // API free plan w/o HTTPS
    }
    
    var params: [String: Any] {
        var headers = [String: Any]()
        headers["access_key"] = accessKey
        return headers
    }
}
