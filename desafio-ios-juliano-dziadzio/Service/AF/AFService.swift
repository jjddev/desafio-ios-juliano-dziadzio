import Foundation
import Alamofire

class AFService: ServiceProtocol {
    
    static let shared = Session()
    
    func fetchData<T>(endPoint: ApiRoute, resultType: T.Type, completionHandler: @escaping (T) -> Void) where T : Decodable, T : Encodable {
        AF.request(endPoint.route).response { response in
            print(response)
            completionHandler(response.data as! T)
        }
    }
    
    func getImage(urlDownload: String, completionHander: @escaping (Data) -> Void) {
        
    }
    
    
}
