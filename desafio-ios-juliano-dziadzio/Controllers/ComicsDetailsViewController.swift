import UIKit

class ComicsDetailsViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    var characterId: Int = -1
    var comicResponse: ComicResponse?  {
        didSet {
            populateScreenFields()
        }
    }
    
    var blobImage: Data = Data() {
        didSet {
            setImage()
        }
    }
    
    
    //var comic: ComicModel = ComicModel()
    
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var comicTitle: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var shortResume: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Most expensive comic"
        fetchComics()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    private func fetchComics() {
        //print(self.characterId)
        Service().fetchData(endPoint: ApiRoute.comics(characterId), resultType: ComicResponse.self, completionHandler: { response in
            print(response)
            
            let comic = response.data.results[0]
            self.comicResponse = response
            let url = ApiRoute.image(comic.thumbnail.path, ImageSize.portraitFantastic.rawValue, comic.thumbnail.fileExtension)
            Service().getImage(urlDownload: url.route)  { downloadImage in
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
            }
        }
    }
    
    private func setImage() {
        DispatchQueue.main.async {
           self.cover.image = UIImage(data: self.blobImage)
        }
    }
    
}
