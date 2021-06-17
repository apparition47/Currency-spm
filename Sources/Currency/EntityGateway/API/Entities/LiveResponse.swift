import Foundation

typealias Quotes = [String: Double]

struct LiveResponse: Codable {
    let success: Bool
    
    let terms: String?
    let privacy: String?
    let source: String?
    let timestamp: Date?
    let quotes: Quotes?
    
    let error: ApiLayerError?
}
