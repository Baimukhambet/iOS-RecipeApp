import UIKit

protocol HomeViewControllerProtocol: UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var meals: [Meal] { get }
    func searchTapped(mealName: String)
}


final class HomeViewController: UIViewController, HomeViewControllerProtocol {
    let api = APIModel.shared
    var meals: [Meal] = []
    let tags = ["All", "American", "British", "Canadian", "Chinese", "Croatian", "Dutch", "Egyptian", "Filipino", "French", "Greek", "Indian", "Irish", "Italian", "Jamaican", "Japanese", "Kenyan", "Malaysian", "Mexican", "Moroccan", "Polish", "Portuguese", "Russian", "Spanish", "Thai", "Tunisian", "Turkish", "Vietnamese"]
    let queue = OperationQueue()
    var operations: [IndexPath:Operation] = [:]
    let screenSize = UIApplication.screenSize
    var currentTagIndex = IndexPath(item: 0, section: 0)
    
    weak var homeView: HomeView! {
        return self.view as? HomeView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        loadRecipes()
    }
    
    override func loadView() {
        self.view = HomeView(delegate: self)
    }
    
    func searchTapped(mealName: String) {
        api.getMealByName(mealName: mealName) { meals in
//            print(meals)
        }
    }
    
    
}

//MARK: -Private functions
private extension HomeViewController {
    func loadRecipes() {
        let characters = "abcdefghijklmnopqrstuvwxyz"
        api.getMealByName(mealName: String(characters.randomElement()!)) { meals in
            DispatchQueue.main.async {
                self.meals = meals
                self.homeView.mealsCollectionView.reloadData()
            }
        }
    }
    
    func loadAreaRecipes(area: String) {
        api.getMealsByArea(area: area) { meals in
            self.meals = meals
            DispatchQueue.main.async {
                self.homeView.mealsCollectionView.reloadData()
            }
        }
    }
    
}

//MARK: -UITextField Delegate
extension HomeViewController {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let searchVC = SearchViewController()
        searchVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(searchVC, animated: true)
        textField.resignFirstResponder()
        
    }
}

//MARK: -CollectionView
extension HomeViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeView?.tagsCollectionView {
            return tags.count
        } else {
            return meals.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeView?.tagsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.description(), for: indexPath) as! TagCell
            cell.setup(title: tags[indexPath.item])
            
            if indexPath == currentTagIndex {
                cell.setSelected()
            } else {
                cell.setUnselected()
            }
            
            return cell
        } else if collectionView == homeView?.mealsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCell.description(), for: indexPath) as! MealCell
            let meal = meals[indexPath.item]
            let op = ImageLoadOperation(url: URL(string: meal.strMealThumb!)!)
            cell.addActivityIndicator()
            op.completionBlock = {
                DispatchQueue.main.async {
                    cell.removeActivityInd()
                    cell.mealImage.image = op.image ?? UIImage()
                }
            }
            queue.addOperation(op)
            
            if let existingOperation = operations[indexPath] {
                existingOperation.cancel()
            }
            operations[indexPath] = op
            
            cell.mealTitleLabel.text = meal.strMeal ?? "No title"
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewMealCell.description(), for: indexPath) as! NewMealCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == homeView?.mealsCollectionView {
            return CGSize(width: screenSize.width * 0.4, height: screenSize.height * 0.3)
        } else {
            return CGSize(width: screenSize.width * 0.4, height: collectionView.maxHeight * 0.9)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == homeView?.mealsCollectionView {
            let recipeVC = RecipeViewController(mealID: meals[indexPath.item].idMeal!)
            navigationController?.pushViewController(recipeVC, animated: true)
        }
        else if collectionView == homeView?.tagsCollectionView, indexPath != currentTagIndex {
            let tagArea = tags[indexPath.item]
            if indexPath.item != 0 {
                loadAreaRecipes(area: tagArea)
            } else {
                loadRecipes()
            }
            let cell = collectionView.cellForItem(at: indexPath) as! TagCell
            let prevCell = collectionView.cellForItem(at: currentTagIndex) as? TagCell
            cell.setSelected()
            prevCell?.setUnselected()
            currentTagIndex = indexPath
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let op = operations[indexPath] {
            op.cancel()
        }
    }
}
