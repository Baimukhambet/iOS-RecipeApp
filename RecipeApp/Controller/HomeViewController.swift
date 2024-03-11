import UIKit

protocol HomeViewControllerProtocol: UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var meals: [Meal] { get }
    func searchTapped(mealName: String)
}


final class HomeViewController: UIViewController, HomeViewControllerProtocol {
    let api = APIModel.shared
    var meals: [Meal] = []
    let tags = ["All", "Korean", "Kazakh", "Chinese", "Russian"]
    let queue = OperationQueue()
    var operations: [IndexPath:Operation] = [:]
    let screenSize = UIApplication.screenSize
    
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
            print(meals)
        }
    }
    
    
}

//MARK: -Private functions
private extension HomeViewController {
    func loadRecipes() {
        api.getMealByName(mealName: "a") { meals in
            DispatchQueue.main.async {
//                self.homeView.meals = meals
                self.meals = meals
                self.homeView.updateScreen()
            }
        }
    }
    
    func displayRecipes() {
        
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
            
            if indexPath.item == 0 {
                cell.setSelected()
            } else {
                cell.setUnselected()
            }
            
            return cell
        } else if collectionView == homeView?.mealsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCell.description(), for: indexPath) as! MealCell
            let meal = meals[indexPath.item]
//            api.loadImage(urlString: meal.strMealThumb ?? "") { image in
//                DispatchQueue.main.async {
//                    cell.mealImage.image = image
//                }
//            }
            let op = ImageLoadOperation(url: URL(string: meal.strMealThumb!)!)
            op.completionBlock = {
                DispatchQueue.main.async {
                    cell.mealImage.image = op.image ?? UIImage(systemName: "house.fill")
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
            return CGSize(width: screenSize.width * 0.4, height: collectionView.maxHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == homeView?.mealsCollectionView {
            let recipeVC = RecipeViewController(meal: meals[indexPath.item], image: (collectionView.cellForItem(at: indexPath) as! MealCell).mealImage.image!)
            navigationController?.pushViewController(recipeVC, animated: true)
        }
        return
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let op = operations[indexPath] {
            op.cancel()
        }
    }
}
