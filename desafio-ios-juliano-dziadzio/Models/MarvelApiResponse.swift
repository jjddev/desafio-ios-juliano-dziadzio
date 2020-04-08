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
    let thumbnail: Thumbnail
    
    
    func toModel() -> CharacterModel {
        let path = "\(self.thumbnail.path)/standard_medium.\(self.thumbnail.fileExtension)"
        return CharacterModel(id: self.id, name: self.name, description: self.description, imagePath: path, imageBlob: "")
    }
    
}

struct Thumbnail: Codable {
    let path: String
    let fileExtension: String
    
    enum CodingKeys: String, CodingKey {
        case fileExtension = "extension"
        case path
    }
}

