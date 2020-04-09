import UIKit

class ComicsDetailsViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    var characterId: Int = -1
    var comicResponse: ComicResponse?
    
    var blobImage: Data = Data() {
        didSet {
            populateScreenFields()
        }
    }
    
    
    //var comic: ComicModel = ComicModel()
    
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var comicTitle: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var shortResume: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Comic .... "
        fetchComics()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    private func fetchComics() {
        print(self.characterId)
        Service().fetchComics(characterId: characterId, completionHandler: { response in
            
            print(response)
            
            let comic = response.data.results[0]
            self.comicResponse = response
            let url =  "\(comic.thumbnail.path)/\(ImageSize.portraitFantastic.rawValue).\(comic.thumbnail.fileExtension)"
            Service().getImage(urlDownload: url)  { downloadImage in
                self.blobImage = downloadImage
            }
        })
    }
    
    private func populateScreenFields() {
        if let comic = comicResponse {
            DispatchQueue.main.async {
                self.comicTitle.text = comic.data.results[0].title
                self.shortResume.text = comic.data.results[0].description
                self.price.text = "Price: U$ \(comic.data.results[0].prices[0].price)"
                self.cover.image = UIImage(data: self.blobImage)
            }
        }
    }
}
