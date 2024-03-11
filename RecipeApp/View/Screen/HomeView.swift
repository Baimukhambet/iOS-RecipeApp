import UIKit

class HomeView: UIView {
    var delegate: HomeViewControllerProtocol
    let api = APIModel.shared
    let screenSize = UIApplication.screenSize
    var operations: [IndexPath : Operation] = [:]
    let queue = OperationQueue()
    
    var meals: [Meal] = []
    
    enum CONSTANTS {
        static let searchFontSize: CGFloat = 11.0
        static let searchBorderWidth: CGFloat = 1.3
    }
    
    
    
    lazy var topBigLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.text = "Hello"
        return label
    }()
    
    lazy var topSmallLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textColor = UIColor(hex: "#A9A9A9FF")
        label.text = "What are you cooking today?"
        return label
    }()
    
    lazy var profileIconView: UIImageView = {
        let imgView = UIImageView(image: UIImage(systemName: "person.crop.circle"))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return imgView
    }()
    
    lazy var topLabelStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topBigLabel, topSmallLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 12.0
        
        return stack
    }()
    
    lazy var topStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topLabelStackView, profileIconView])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var searchField: SearchTextField = {
        let field = SearchTextField()
        field.placeholder = "Search recipe"
        field.font = .systemFont(ofSize: CONSTANTS.searchFontSize)
        field.layer.borderColor = UIColor(hex: "#D9D9D9FF")?.cgColor
        field.layer.borderWidth = CONSTANTS.searchBorderWidth
        field.translatesAutoresizingMaskIntoConstraints = false
        field.heightAnchor.constraint(equalToConstant: 40).isActive = true
        field.layer.cornerRadius = 10
        field.delegate = delegate   
        
        let imageAttribute = NSAttributedString(attachment: NSTextAttachment(image: UIImage(systemName: "magnifyingglass")!))
        let textAttribute = NSAttributedString(string: "   Search recipe")
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(imageAttribute)
        attributedString.append(textAttribute)
        
        field.attributedPlaceholder = attributedString
        return field
    }()
    
    lazy var findButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hex: "#129575FF")
        btn.setImage(UIImage(systemName: "slider.horizontal.2.square")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        
        btn.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        btn.addAction(UIAction {[self] _ in
            delegate.searchTapped(mealName: searchField.text ?? "")
            tagsCollectionView.reloadData()
            mainStack.layoutIfNeeded()
        }, for: .touchUpInside)
        
        return btn
    }()
    
    lazy var searchStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 20.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(searchField)
        stack.addArrangedSubview(findButton)
        return stack
    }()
    
    lazy var tagsCollectionView: TagsCollectionView = {
        let colView = TagsCollectionView()
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.heightAnchor.constraint(equalToConstant: 51.0).isActive = true
        colView.dataSource = delegate
        //        colView.register(TagCell.self, forCellWithReuseIdentifier: "TagCell")
        return colView
    }()
    
    lazy var mealsCollectionView: MealCollectionView = {
        let colView = MealCollectionView()
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.heightAnchor.constraint(equalToConstant: screenSize.height * 0.3).isActive = true
        colView.dataSource = delegate
        colView.delegate = delegate
        return colView
    }()
    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15.0
        stack.alignment = .fill
        stack.addArrangedSubview(searchStack)
        stack.addArrangedSubview(tagsCollectionView)
        stack.addArrangedSubview(mealsCollectionView)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var newRecipesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.text = "New Recipes"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var newMealsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let colView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colView.showsHorizontalScrollIndicator = false
        colView.dataSource = delegate
        colView.delegate = delegate
        colView.register(NewMealCell.self, forCellWithReuseIdentifier: NewMealCell.description())
        colView.translatesAutoresizingMaskIntoConstraints = false
        return colView
    }()
    
    init(delegate: HomeViewControllerProtocol) {
        self.delegate = delegate
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Views
    
    private func setup() {
        self.addSubview(topStackView)
        self.addSubview(mainStack)
        self.addSubview(newRecipesLabel)
        self.addSubview(newMealsCollectionView)
        setupTopStackView()
        setupMainStackView()
        setupNewMealsView()
    }
    

    
    private func setupTopStackView() {
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 64),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
        ])
    }
    
    private func setupMainStackView() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 30),
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
        ])
    }
    
    private func setupNewMealsView() {
        NSLayoutConstraint.activate([
            newRecipesLabel.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 20),
            newRecipesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
//            newRecipesLabel.topAnchor.constraint(equalTo: mealsCollectionView.bottomAnchor, constant: 20),
            
            newMealsCollectionView.topAnchor.constraint(equalTo: newRecipesLabel.bottomAnchor, constant: 32),
            newMealsCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            newMealsCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            newMealsCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -108),
        ])
    }
    
    //MARK: -Update Functions
    func updateScreen() {
        mealsCollectionView.reloadData()
    }
    
}


//MARK: -API Functions
private extension HomeView {
    func displayRecipes() {
        
    }
}
