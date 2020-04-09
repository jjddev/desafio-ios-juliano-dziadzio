import Foundation
import UIKit

class Service {
    
    private func generateToken() -> Token {
        let timestamp = String(Date().timeIntervalSince1970)
        let token = "\(timestamp)\(AppSettings.ApiPrivateKey)\(AppSettings.ApiPublicKey)".insecureMD5Hash() ?? ""
        
        return Token(value: token, timestamp: timestamp)
    }
    
    func fetchCharacters(completionHandler: @escaping (_ result: MarvelApiResponse) -> Void) {
        
        let token = generateToken()
        let urls = AppSettings.ApiUrl + "characters?ts=\(token.timestamp)&apikey=\(AppSettings.ApiPublicKey)&hash=\(token.value)&limit=15&offset=0"
        
        let url = URL(string: urls)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { result in
            switch result {
                case .success(let data):
                    let json = try! JSONDecoder().decode(MarvelApiResponse.self, from: data)
                    completionHandler(json)
                case .failure(let error):
                    NSLog(error.localizedDescription)
                    //completionHandler("")
            }
        }
        
        task.resume()
    }
    
    func fetchComics(characterId: Int, completionHandler: @escaping (_ result: ComicResponse) -> Void) {
        
        let token = generateToken()
        let urls = AppSettings.ApiUrl + "characters/\(characterId)/comics?ts=\(token.timestamp)&apikey=\(AppSettings.ApiPublicKey)&hash=\(token.value)"
        
        let url = URL(string: urls)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { result in
            switch result {
                case .success(let data):
                    let json = try! JSONDecoder().decode(ComicResponse.self, from: data)
                    completionHandler(json)
                case .failure(let error):
                    NSLog(error.localizedDescription)
                    //completionHandler("")
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




