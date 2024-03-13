//
import UIKit

class SearchView: UIView {
    private var delegate: SearchViewControllerProtocol
    
    enum CONSTANTS {
        static let searchFontSize: CGFloat = 11.0
        static let searchBorderWidth: CGFloat = 1.3
    }
    
    init(delegate: SearchViewControllerProtocol) {
        self.delegate = delegate
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Subviews
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
        
        btn.addAction(UIAction { _ in self.buttonTapped() }, for: .touchUpInside)
        
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
    
    lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent Search"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var searchCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textColor = UIColor(hex: "#A9A9A9FF")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var headingStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(headingLabel)
        stack.addArrangedSubview(searchCountLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let colView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colView.delegate = delegate
        colView.dataSource = delegate
        colView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.description())
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.showsVerticalScrollIndicator = false
        return colView
    }()
    
    func buttonTapped() {
//        print("Tapped")
        delegate.searchButtonTapped(mealName: searchField.text ?? "")
        searchField.resignFirstResponder()
    }
    
    
    //MARK: - Setup
    private func setup() {
        self.backgroundColor = .systemBackground
        setupTextField()
        setupHeadingLabel()
        setupCollectionView()
    }
    
    
}

//MARK: -Private Methods
private extension SearchView {
    func setupTextField() {
        self.addSubview(searchStack)
        NSLayoutConstraint.activate([
            searchStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            searchStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            searchStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 17),
        ])
    }
    
    func setupHeadingLabel() {
        self.addSubview(headingStack)
        NSLayoutConstraint.activate([
            headingStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            headingStack.topAnchor.constraint(equalTo: self.searchStack.bottomAnchor, constant: 20),
            headingStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
        ])
    }
    
    func setupCollectionView() {
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    

}

//MARK: -Delegate methods
extension SearchView {
    func startSearch() {
        searchField.becomeFirstResponder()
    }
}

