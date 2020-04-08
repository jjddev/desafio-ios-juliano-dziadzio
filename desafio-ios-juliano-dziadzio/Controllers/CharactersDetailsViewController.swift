import UIKit

class CharactersDetailsViewController: UIViewController, Storyboarded {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var shortResume: UILabel!
    
    weak var coordinator: MainCoordinator?
    var character: CharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateScreenFields()
    }
    
    private func populateScreenFields(){
        if let character = character {
            self.name.text = character.name
            self.shortResume.text = character.description
            self.navigationItem.title = "\(character.name) details"
        }
    }
    
    private func comicDetails() {
        coordinator?.showComicDetails()
    }
    
    @IBAction func didTapComicDetails(_ sender: Any) {
        comicDetails()
    }
}
