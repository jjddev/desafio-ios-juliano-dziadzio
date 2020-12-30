import Foundation

enum ServiceImplementation {
    case AF
    case Native
}

protocol ServiceProtocol {
    func fetchData<T: Codable>(endPoint: ApiRoute, resultType: T.Type, completionHandler: @escaping (_  result: T) -> Void)
    func getImage(urlDownload: String, completionHander: @escaping (Data) -> Void)
}


