//
//  TagCell.swift
//  RecipeApp
//
//  Created by Timur Baimukhambet on 18.01.2024.
//

import UIKit

class TagCell: UICollectionViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor(hex: "#129575FF")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.contentView.backgroundColor = UIColor.white
        self.contentView.layer.cornerRadius = 10
        self.contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
        ])
    }
    
    func setSelected() {
        self.contentView.backgroundColor = UIColor(hex: "#129575FF")
        self.titleLabel.textColor = .white
    }
    
    func setUnselected() {
        self.contentView.backgroundColor = .white
        self.titleLabel.textColor = UIColor(hex: "#129575FF")
    }
    
    func setup(title: String) {
        self.titleLabel.text = title
    }
}
