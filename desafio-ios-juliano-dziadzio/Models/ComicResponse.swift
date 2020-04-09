import Foundation

struct ComicResponse {
    var data: [InnerData]
    
    struct InnerData {
        let results: [Comic]
        let total: Int
    }
}

struct Comic {
    let id: Int
    let title: String
    let description: String
    
    let thumbnail: Thumbnail
    
    let prices: [Price]
    
    struct Price {
        let type: String
        let price: Decimal
    }
}
