import UIKit

protocol SearchViewControllerProtocol: UITextFieldDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func searchButtonTapped(mealName: String)
}

final class SearchViewController: UIViewController, SearchViewControllerProtocol {
    private var searchResults: [Meal] = []
    private let api = APIModel.shared
    weak var mainView: SearchView! {
        return self.view as? SearchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search recipes"
        navigationItem.backButtonTitle = ""
        
        dismissKeyboard()
    }
    

    override func loadView() {
        self.view = SearchView(delegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.startSearch()
        
    }

}

extension SearchViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.description(), for: indexPath) as! SearchCell
        
        let meal = searchResults[indexPath.item]
        api.loadImage(urlString: meal.strMealThumb ?? "") { image in
            DispatchQueue.main.async {
                cell.imageBackground.image = image
            }
        }
        cell.titleLabel.text = meal.strMeal ?? "No title"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 7
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let recipeVC = RecipeViewController(meal: searchResults[indexPath.item], image: cell.imageBackground.image!)
        let recipeVC = RecipeViewController(mealID: searchResults[indexPath.item].idMeal!)
        navigationController?.pushViewController(recipeVC, animated: true)
    }
    
}

//MARK: - Search Meals Functions
extension SearchViewController {
    func searchButtonTapped(mealName: String) {
        mainView.headingLabel.text = "Search Result"
        api.getMealByName(mealName: mealName) { meals in
            self.searchResults = meals
//            print(self.searchResults.count)
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
                self.mainView.searchCountLabel.text = "\(meals.count) results"
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mainView.buttonTapped()
        return true
    }
}
