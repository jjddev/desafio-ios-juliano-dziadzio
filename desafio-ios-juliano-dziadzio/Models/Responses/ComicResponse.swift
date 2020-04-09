import Foundation

struct ComicResponse: Codable {
    public var data: InnerData
    
    struct InnerData: Codable {
        public var results: [Comic]
        public var total: Int
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode(ComicResponse.InnerData.self, forKey: .data)

     }
}

struct Comic: Codable {
    let id: Int
    let title: String
    let description: String
    
    let thumbnail: Thumbnail
    
    let prices: [Price]
    
    struct Price: Codable {
        let type: String
        let price: Decimal
    }
}
