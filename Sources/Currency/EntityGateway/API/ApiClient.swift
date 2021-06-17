import Foundation
import Alamofire

typealias CallResponse<T> = ((T?, Error?) -> Void)?

struct APIRequest {
    var requestParam: ApiCallRequest
    
    private var parameters: Parameters {
        get {
            requestParam.params
        }
    }
    
    private var urlRequest: URLRequest {
        let requestURL = URL(string: "\(requestParam.baseURL)/\(requestParam.path)")!
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 5
        return request
    }
}

extension APIRequest: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        try URLEncoding.queryString.encode(urlRequest, with: parameters)
    }
}

extension APIRequest: URLConvertible {
    func asURL() throws -> URL {
        try urlRequest.asURLRequest().url!
    }
}

protocol ResponseHandler {
    static func handleResponse<T: Codable>(_ response: DataResponse<Data>, completion: CallResponse<T>)
}

extension ResponseHandler {
    static func handleResponse<T: Codable>(_ response: DataResponse<Data>, completion: CallResponse<T>) {
        switch response.result {
        case .success(let value):
            do {
                let parsedResponse = try ApiLayerJSONDecoder().decode(T.self, from: value)
                completion?(parsedResponse, nil)
            } catch let err {
                completion?(nil, err)
            }
        case .failure(let err):
            completion?(nil, err)
        }
    }
}

struct APIManager: ResponseHandler {
    static func execute<T: Codable>(request: ApiCallRequest, completion: CallResponse<T>) {
        let apiRequest = APIRequest(requestParam: request)
        let afReq = Alamofire.request(apiRequest).validate()
        #if DEBUG
        print(afReq.debugDescription) // cURL
        afReq.responseString { response in
            print(response)
        }
        #endif
        afReq.responseData { response in
            self.handleResponse(response, completion: completion)
        }
    }
}
