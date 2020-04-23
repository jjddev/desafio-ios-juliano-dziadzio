/*
- url, chave publica e privada no xcodeproj, como variáveis do app.
- characters um array com a response "bruta", charactersModel é o tipo mais para o app trabalhar,
ele usa o mesmo blob para exibir a imagem tanto na listagem quanto na tela de detalhes, assim evitando uma nova request pesada.
 */

import UIKit

class MainViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let cellName = String(describing: CharacterTableViewCell.self)
    var characters = [Character]()
    var charactersModel = [CharacterModel]()
    var pagination = Pagination()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = "Marvel characters list"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if characters.isEmpty {
            activityIndicator.startAnimating()
            fetchCharacters()
        }
    }
    
    func updateTableItems() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.loadingView.isHidden = true
        }
    }
    
    func fetchCharacters() {
        let limit = pagination.limit
        let offset = pagination.offset
        
        Service().fetchData(endPoint: ApiRoute.characters(limit, offset), resultType: CharacterResponse.self, completionHandler: { response in
            print(response.data.results)
            self.pagination.offset = offset == 0 ? self.pagination.limit + 1 : self.pagination.offset + self.pagination.limit
            self.pagination.total = response.data.total
            
            self.characters += response.data.results
            for item in response.data.results {
                let url = ApiRoute.image(item.thumbnail.path, ImageSize.landscapeMedium.rawValue, item.thumbnail.fileExtension)
                Service().getImage(urlDownload: url.route) { downloadImage in
                    let character = item.toModel(imageBlob: downloadImage)
                    self.charactersModel.append(character)
                }
            }
                
            self.updateTableItems()
        })
    }
    
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? CharacterTableViewCell {
            let character = charactersModel[indexPath.row]
            cell.name.text =  character.name
            cell.img.image = UIImage(data: character.imageBlob)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = charactersModel[indexPath.row]
        coordinator?.showCharacterDetails(model: character)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if charactersModel.count-1 == indexPath.row && charactersModel.count-1 != pagination.total {
            fetchCharacters()
        }
    }
    
}
