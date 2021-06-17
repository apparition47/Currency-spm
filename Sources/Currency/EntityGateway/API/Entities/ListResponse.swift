typealias Currencies = [String: String]

struct ListResponse: Codable {
    let success: Bool
    
    let terms: String?
    let privacy: String?
    let currencies: Currencies?
    
    let error: ApiLayerError?
}
