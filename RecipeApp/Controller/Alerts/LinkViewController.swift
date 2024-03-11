import UIKit

final class LinkViewController: UIViewController {
    private let link: String
    
    init(link: String) {
        self.link = link
        super.init(nibName: nil, bundle: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Subviews
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Recipe Link"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Copy recipe link and share your recipe link with  friends and family."
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = UIColor(hex: "#797979FF")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var linkLabel: UILabel = {
        let label = UILabel()
        label.text = link
        label.font = .systemFont(ofSize: 11, weight: .medium)
        label.textColor = UIColor(hex: "#797979FF")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var linkBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(hex: "#D9D9D9FF")
        view.layer.cornerRadius = 9
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var copyButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Copy Link", for: .normal)
        btn.backgroundColor = .init(hex: "#129575FF")
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 9
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var closeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark")?.withTintColor(.init(hex: "#484848FF")!, renderingMode: .alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 6).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 6).isActive = true
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }


}

//MARK: - Private Functions
private extension LinkViewController {
    func setupView() {
        
        view.layer.cornerRadius = 20
        view.addSubview(headerLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(linkBackView)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            linkBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            linkBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            linkBackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            linkBackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
        
        linkBackView.addSubview(linkLabel)
        linkBackView.addSubview(copyButton)
        
        NSLayoutConstraint.activate([
            linkLabel.centerYAnchor.constraint(equalTo: linkBackView.centerYAnchor),
            linkLabel.leadingAnchor.constraint(equalTo: linkBackView.leadingAnchor, constant: 14),
            
            copyButton.topAnchor.constraint(equalTo: linkBackView.topAnchor),
            copyButton.bottomAnchor.constraint(equalTo: linkBackView.bottomAnchor),
            copyButton.trailingAnchor.constraint(equalTo: linkBackView.trailingAnchor),
            copyButton.widthAnchor.constraint(equalTo: linkBackView.widthAnchor, multiplier: 0.33)
        ])
    }
}