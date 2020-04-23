import Foundation

struct ComicResponse: Codable {
    public let data: ComicData
    public let code: Int
    public let etag:  String
    public let status: String
}

struct ComicData: Codable {
    public var results: [Comic]
    public var total: Int
}

struct Comic: Codable {
    let id: Int
    let title: String
    let description: String
    
    let thumbnail: Thumbnail
    
    let prices: [Price]
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, thumbnail, prices
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? "No description avaliable"
        thumbnail = try container.decodeIfPresent(Thumbnail.self, forKey: .thumbnail) ?? Thumbnail(path: "", fileExtension: "")
        prices = try container.decodeIfPresent([Price].self, forKey: .prices) ?? [Price]()
    }
    
}

struct Price: Codable {
    let type: String
    let price: Decimal
}
