import Foundation

enum ApiRoute {
    case characters(Int = 15, Int = 0)
    case comics(Int)
    case image(String, String, String)
    
    
    var route: String {
        
        let token = generateToken()
        let authentication = "?ts=\(token.timestamp)&apikey=\(AppSettings.ApiPublicKey)&hash=\(token.value)"
        
        switch self {
        case .characters(let limit, let offset):
            return AppSettings.ApiUrl + "characters" + authentication + "&limit=\(limit)&offset=\(offset)"
        case .comics(let characterId):
            return AppSettings.ApiUrl + "characters/\(characterId)/comics" + authentication
        case .image(let path, let size, let fileExtension):
            return "\(path)/\(size).\(fileExtension)"
        }
    }
    
    
    private func generateToken() -> Token {
        let timestamp = String(Date().timeIntervalSince1970)
        let token = "\(timestamp)\(AppSettings.ApiPrivateKey)\(AppSettings.ApiPublicKey)".insecureMD5Hash() ?? ""
        
        return Token(value: token, timestamp: timestamp)
    }
    
}
