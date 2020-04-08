import Foundation

struct MarvelApiResponse: Codable {
    public var data: innerData
}

struct innerData: Codable {
    public var results: [Character]
    public var total: Int
}

struct Character: Codable {
    let id: Int
    let name: String
    let description: String
}

