import Foundation
@testable import Currency

extension Result: Equatable { }
public func ==<T>(lhs: Result<T>, rhs: Result<T>) -> Bool {
    String(describing: lhs) == String(describing: rhs)
}

public func parse<T: Decodable>(jsonFile: String, as type: T.Type) -> T {
    let testBundle = Bundle.module
    let url = testBundle.url(forResource: jsonFile, withExtension: "json")!
    let data = try! Data(contentsOf: url)
    return try! ApiLayerJSONDecoder().decode(T.self, from: data)
}
