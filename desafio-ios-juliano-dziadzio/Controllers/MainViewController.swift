// url, chave publica e privada no xcodeproj, como variáveis do app
import UIKit

class MainViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let cellName = String(describing: CharacterTableViewCell.self)
    var characters = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = "Marvel characters list"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.startAnimating()
        
        Service().fetchCharacters(completionHandler: { response in
            print(response.data.results)
            self.characters = response.data.results
            self.updateTableItems()
        })
    }
    
    func updateTableItems() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.loadingView.isHidden = true
        }
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? CharacterTableViewCell {
            cell.name.text =  characters[indexPath.row].name
            cell.img = UIImageView(image:  UIImage(contentsOfFile: "standard_medium"))
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let charcter = characters[indexPath.row]
        coordinator?.showCharacterDetails(model: charcter.toModel())
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == characters.count - 1 {
            
        }
    }
}
