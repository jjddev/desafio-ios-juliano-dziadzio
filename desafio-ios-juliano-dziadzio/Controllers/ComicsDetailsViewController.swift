import UIKit

class ComicsDetailsViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Comic .... "
    }
}
