import UIKit

class CharactersDetailsViewController: UIViewController, Storyboarded {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var shortResume: UILabel!
    
    weak var coordinator: MainCoordinator?
    var character: CharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let charcter = character {
            self.name.text = charcter.name
            self.shortResume.text = charcter.description
        }
    }
}
