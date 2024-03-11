import UIKit

final class RecipeView: UIView {
    private let delegate: RecipeViewDelegate
    private enum CONSTANTS {
        static let backgroundColorButton = "#129575FF"
        static let fontColorButton = "#71B1A1FF"
    }
    private var currentIndex = 0
    
    //MARK: - Subviews
    let scrollView = UIScrollView()
    let contentView = UIView()
    lazy var mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: UIApplication.screenSize.height / 5).isActive = true
        imageView.backgroundColor = .black
        return imageView
    }()
    
    lazy var mealTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Some dish label"
        return label
    }()
    
    lazy var ingridientButton = createSegmentButton(index: 0)
    lazy var procedureButton = createSegmentButton(index: 1)
    
    lazy var segmentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 15
        
        stack.addArrangedSubview(ingridientButton)
        stack.addArrangedSubview(procedureButton)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .fill
        stack.addArrangedSubview(mealImageView)
        stack.addArrangedSubview(mealTitleLabel)
        stack.addArrangedSubview(segmentStack)
        
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var ingredientsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(hex: "#A9A9A9FF")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var instructionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#D9D9D9FF")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.addSubview(instructionLabel)
        NSLayoutConstraint.activate([
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            instructionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            instructionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
        ])
        return view
    }()
    
    //MARK: - Delegate functions
    public func createIngredientView(name: String, quantity: String, completion: @escaping (UIImageView) -> ()) {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#D9D9D9FF")
        view.layer.cornerRadius = 12
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 52).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.text = name
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let quantityLabel = UILabel()
        quantityLabel.text = quantity
        quantityLabel.textColor = UIColor(hex: "#A9A9A9FF")
        quantityLabel.font = .systemFont(ofSize: 14, weight: .regular)
        quantityLabel.numberOfLines = 0
        quantityLabel.textAlignment = .right
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(quantityLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 29),
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -23),
            
            quantityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            quantityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            quantityLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
//            quantityLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
            quantityLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.4)
        ])
        
        ingredientsStackView.addArrangedSubview(view)
        completion(imageView)
    }
    
    
    //MARK: - init
    init(delegate: RecipeViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private functions
private extension RecipeView {
    func setup() {
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
        
        contentView.addSubview(ingredientsStackView)
        NSLayoutConstraint.activate([
            ingredientsStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24),
            ingredientsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ingredientsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ingredientsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func createSegmentButton(index: Int) -> UIButton {
        let button = UIButton()
        if index == 0 {
            button.backgroundColor = UIColor(hex: CONSTANTS.backgroundColorButton)
            button.setTitle("Ingridient", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.tag = 0
        } else {
            button.backgroundColor = .white
            button.setTitleColor(UIColor(hex: CONSTANTS.fontColorButton), for: .normal)
            button.setTitle("Procedure", for: .normal)
            button.tag = 1
        }
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 11, weight: .semibold)
        button.addAction(UIAction { [self] _ in
            if currentIndex != button.tag {
                button.backgroundColor = UIColor(hex: CONSTANTS.backgroundColorButton)
                button.setTitleColor(.white, for: .normal)
                
                if currentIndex == 0 {
                    delegate.hideIngredientView()
                    ingridientButton.backgroundColor = .white
                    ingridientButton.setTitleColor(UIColor(hex: CONSTANTS.fontColorButton), for: .normal)
                } else {
                    delegate.hideInstructionView()
                    procedureButton.backgroundColor = .white
                    procedureButton.setTitleColor(UIColor(hex: CONSTANTS.fontColorButton), for: .normal)
                }
                currentIndex = button.tag
            }
        }, for: .touchUpInside)
        return button
    }
    
}
