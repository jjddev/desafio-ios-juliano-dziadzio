import Foundation

enum ApiRoute {
    case characters
    case comics(Int)
    case imageCharacter(String, String, String)
    
    
    var route: String {
        switch self {
        case .characters:
            return AppSettings.ApiUrl + "characters"
        case .comics(let characterId):
            return AppSettings.ApiUrl + "characters/\(characterId)/comics"
        case .imageCharacter(let path, let size, let fileExtension):
            return "\(path)/\(size).\(fileExtension)"
        }
    }
}
