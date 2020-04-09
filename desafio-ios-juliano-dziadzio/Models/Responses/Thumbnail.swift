import Foundation

struct Thumbnail: Codable {
    let path: String
    let fileExtension: String
    
    enum CodingKeys: String, CodingKey {
        case fileExtension = "extension"
        case path
    }
}
