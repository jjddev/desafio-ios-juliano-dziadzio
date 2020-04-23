import Foundation
import UIKit

class Service {
    
    func fetchData<T: Codable>(endPoint: ApiRoute, resultType: T.Type, completionHandler: @escaping (_  result: T) -> Void) {
        
        guard let url = URL(string: endPoint.route) else { return }
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { result in
            switch result {
                case .success(let data):
                    //print("Decode to: \(T.self)")
                    //print(String(data: data, encoding: .utf8))
                    let json = try! JSONDecoder().decode(T.self, from: data)
                    completionHandler(json)
                case .failure(let error):
                    NSLog(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func getImage(urlDownload: String, completionHander: @escaping (Data) -> Void) {
        guard let url = URL(string: urlDownload) else { return }
        
        DispatchQueue.global().sync {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.global().sync {
                completionHander(imageData)
            }
        }
    }
    
}
