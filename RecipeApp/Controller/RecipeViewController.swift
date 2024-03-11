import UIKit


protocol RecipeViewDelegate {
    func hideIngredientView()
    func hideInstructionView()
}

final class RecipeViewController: UIViewController, RecipeViewDelegate {
    weak var recipeView: RecipeView! {
        return self.view as? RecipeView
    }
    let api = APIModel.shared
    var meal: Meal?
    var image: UIImage?
    let mealID: String
    
    lazy var shareAction = UIAction(title: "Share", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: [], state: .mixed) {_ in
        self.presentShareVC()
    }
    
    lazy var menu: UIMenu = {
        let menu = UIMenu(children: [shareAction])
        return menu
    }()
    
    //MARK: - init
    init(mealID: String) {
        self.mealID = mealID
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - State functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRightBarButton()
        loadMeal()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setup()
    }
    
    override func loadView() {
        self.view = RecipeView(delegate: self)
    }
    
    func hideIngredientView() {
        recipeView.ingredientsStackView.removeFromSuperview()
        
        recipeView.contentView.addSubview(recipeView.instructionView)
        NSLayoutConstraint.activate([
            recipeView.instructionView.topAnchor.constraint(equalTo: recipeView.stackView.bottomAnchor, constant: 24),
            recipeView.instructionView.leadingAnchor.constraint(equalTo: recipeView.contentView.leadingAnchor),
            recipeView.instructionView.trailingAnchor.constraint(equalTo: recipeView.contentView.trailingAnchor),
            recipeView.instructionView.bottomAnchor.constraint(equalTo: recipeView.contentView.bottomAnchor)
        ])
        loadProcedureData()
    }
    
    func hideInstructionView() {
        recipeView.instructionView.removeFromSuperview()
        
        recipeView.contentView.addSubview(recipeView.ingredientsStackView)
        NSLayoutConstraint.activate([
            recipeView.ingredientsStackView.topAnchor.constraint(equalTo: recipeView.stackView.bottomAnchor, constant: 24),
            recipeView.ingredientsStackView.leadingAnchor.constraint(equalTo: recipeView.contentView.leadingAnchor),
            recipeView.ingredientsStackView.trailingAnchor.constraint(equalTo: recipeView.contentView.trailingAnchor),
            recipeView.ingredientsStackView.bottomAnchor.constraint(equalTo: recipeView.contentView.bottomAnchor)
        ])
    }
}

//MARK: - Private functions
private extension RecipeViewController {
    func setupRightBarButton() {
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), primaryAction: nil, menu: menu)
    }
    
    func setup() {
        recipeView.mealImageView.image = image
        recipeView.mealTitleLabel.text = meal?.strMeal ?? "No title"
        
        setupIngredientsData()
    }
    
    func setupIngredientsData() {
        let ingLiteral = "strIngredient"
        let measureLiteral = "strMeasure"
        
        for index in 1...20 {
            if let ing = meal?.value(forKey: ingLiteral + String(index)) as? String, let measure = meal?.value(forKey: measureLiteral + String(index)) as? String, (ing != "" && measure != "") {
                recipeView.createIngredientView(name: ing, quantity: measure) { [weak self] imgView in
                    guard let _ = self else { return }
                    let url = URL(string: "https://www.themealdb.com/images/ingredients/\(ing).png")!
                    let op = ImageLoadOperation(url: url)
                    op.completionBlock = {
                        DispatchQueue.main.async {
                            imgView.image = op.image
                        }
                    }
                    op.start()
                }
            }
        }
    }
    
    func loadProcedureData() {
        recipeView.instructionLabel.text = meal?.strInstructions ?? "No Instructions"
    }
    
    func loadMeal() {
        api.getMealById(id: mealID) { meal in
            self.meal = meal
            DispatchQueue.main.async { [self] in
                recipeView.mealTitleLabel.text = meal?.strMeal ?? "No title"
                setupIngredientsData()
            }
            let op = ImageLoadOperation(url: URL(string: meal!.strMealThumb!)!)
            op.completionBlock = {
                DispatchQueue.main.async {
                    self.recipeView.mealImageView.image = op.image!
                }
            }
            op.start()
        }
    }
    
    func presentShareVC() {
        let shareVC = LinkViewController(link: meal!.idMeal!)
        shareVC.willMove(toParent: self)
        recipeView.addSubview(shareVC.view)
        NSLayoutConstraint.activate([
            shareVC.view.centerXAnchor.constraint(equalTo: recipeView.centerXAnchor),
            shareVC.view.centerYAnchor.constraint(equalTo: recipeView.centerYAnchor),
            shareVC.view.leadingAnchor.constraint(equalTo: recipeView.leadingAnchor, constant: 30),
            shareVC.view.trailingAnchor.constraint(equalTo: recipeView.trailingAnchor, constant: -30),
        ])
        
        recipeView.isUserInteractionEnabled = false
    }
    

}
