import Foundation
import UIKit

class Service {
    
    private func generateToken() -> Token {
        let timestamp = String(Date().timeIntervalSince1970)
        let token = "\(timestamp)\(AppSettings.ApiPrivateKey)\(AppSettings.ApiPublicKey)".insecureMD5Hash() ?? ""
        
        return Token(value: token, timestamp: timestamp)
    }
    
    func fetchData<T: Codable>(endPoint: ApiRoute, resultType: T.Type, completionHandler: @escaping (_  result: T) -> Void) {
        let token = generateToken()
        let urls = endPoint.route + "?ts=\(token.timestamp)&apikey=\(AppSettings.ApiPublicKey)&hash=\(token.value)&limit=15&offset=0"
        
        guard let url = URL(string: urls) else { return }
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { result in
            switch result {
                case .success(let data):
                    let json = try! JSONDecoder().decode(T.self, from: data)
                    completionHandler(json)
                case .failure(let error):
                    NSLog(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func getImage(urlDownload: String, completionHander: @escaping (Data) -> Void) {
        let url = URL(string: urlDownload)!
        
        DispatchQueue.global().sync {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.global().sync {
                completionHander(imageData)
            }
        }
    }
    
}




