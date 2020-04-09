import Foundation

struct ComicResponse: Codable {
    var data: [InnerData]
    
    struct InnerData: Codable {
        let results: [Comic]
        let total: Int
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
