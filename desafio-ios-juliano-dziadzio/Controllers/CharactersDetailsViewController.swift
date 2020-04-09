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
            self.img.image = UIImage(data: character.imageBlob)
        }
    }
    
    private func comicDetails() {
        coordinator?.showComicDetails(from: character?.id ?? -1)
    }
    
    @IBAction func didTapComicDetails(_ sender: Any) {
        comicDetails()
    }
}
