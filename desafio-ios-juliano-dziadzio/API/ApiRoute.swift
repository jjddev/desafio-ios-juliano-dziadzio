import Foundation

enum ApiRoute {
    case characters
    case comics(Int)
    case image(String, String, String)
    
    
    var route: String {
        switch self {
        case .characters:
            return AppSettings.ApiUrl + "characters"
        case .comics(let characterId):
            return AppSettings.ApiUrl + "characters/\(characterId)/comics"
        case .image(let path, let size, let fileExtension):
            return "\(path)/\(size).\(fileExtension)"
        }
    }
}
