import UIKit

class SearchCell: UICollectionViewCell {
    
    lazy var imageBackground: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.contentView.addSubview(imageBackground)
        self.contentView.addSubview(titleLabel)
        
        self.contentView.layer.cornerRadius = 10
        self.contentView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            imageBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -25),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
        ])
        
        let maskView = UIView()
        maskView.translatesAutoresizingMaskIntoConstraints = false
        imageBackground.addSubview(maskView)
        maskView.backgroundColor = .black
        maskView.alpha = 0.4
        
        NSLayoutConstraint.activate([
            maskView.topAnchor.constraint(equalTo: imageBackground.topAnchor),
            maskView.leadingAnchor.constraint(equalTo: imageBackground.leadingAnchor),
            maskView.trailingAnchor.constraint(equalTo: imageBackground.trailingAnchor),
            maskView.bottomAnchor.constraint(equalTo: imageBackground.bottomAnchor),
        ])
        
        
        
    }
    
    func setData(image: UIImage, title: String) {
        self.imageBackground.image = image
        self.titleLabel.text = title
    }
}
