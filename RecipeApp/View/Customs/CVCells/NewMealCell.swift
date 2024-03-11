//
//  NewMealCell.swift
//  RecipeApp
//
//  Created by Timur Baimukhambet on 20.01.2024.
//

import UIKit

class NewMealCell: UICollectionViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(hex: "#484848FF")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Some meal name"
        return label
    }()
    
    lazy var creatorIconView: UIImageView = {
        let imgView = UIImageView(image: UIImage(systemName: "person.crop.circle"))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        return imgView
    }()
    
    lazy var creatorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textColor = UIColor(hex: "#A9A9A9FF")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "By Someone"
        return label
    }()
    
    lazy var mealImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .black
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = UIColor(hex: "#A9A9A9FF")
        contentView.addSubview(titleLabel)
        contentView.addSubview(mealImageView)
//        contentView.addSubview(creatorIconView)
//        contentView.addSubview(creatorLabel)
        
        NSLayoutConstraint.activate([
            mealImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
//            mealImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            mealImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mealImageView.widthAnchor.constraint(equalToConstant: 80),
            mealImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
//            titleLabel.trailingAnchor.constraint(equalTo: mealImageView.leadingAnchor, constant: -8),
            titleLabel.widthAnchor.constraint(equalToConstant: 80),
            
//            creatorIconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            creatorIconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
//            
//            creatorLabel.leadingAnchor.constraint(equalTo: creatorIconView.trailingAnchor, constant: 8),
//            creatorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            

            
//            mealImageView.widthAnchor.constraint(equalToConstant: UIApplication.screenSize.width * 0.4)
        ])
    }
}
