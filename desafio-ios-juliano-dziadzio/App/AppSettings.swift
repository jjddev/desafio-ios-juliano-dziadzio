import Foundation

struct AppSettings {
        
    public static let ApiPublicKey = get(key: "API_PUBLIC_KEY")
    public static let ApiPrivateKey = get(key: "API_PRIVATE_KEY")
    public static let ApiUrl = get(key: "BASE_URL")

    private static func get(key: String) -> String {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String ?? ""
    }
    
    private init() {}
}
