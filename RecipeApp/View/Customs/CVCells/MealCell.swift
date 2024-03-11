//
//  MealCell.swift
//  RecipeApp
//
//  Created by Timur Baimukhambet on 18.01.2024.
//

import UIKit

class MealCell: UICollectionViewCell {
    lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#D9D9D9FF")
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mealImage: RoundUIImageView = {
        let imgView = RoundUIImageView()
        imgView.backgroundColor = .black
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    lazy var mealTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(hex: "#484848FF")
        label.text = "Looooong title for a dish"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timeTag: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textColor = UIColor(hex: "#A9A9A9FF")
        label.text = "Time"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timeValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .bold)
        label.textColor = UIColor(hex: "#484848FF")
        label.text = "15 Min"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(background)
        contentView.addSubview(mealTitleLabel)
        contentView.addSubview(mealImage)
        contentView.addSubview(timeTag)
        contentView.addSubview(timeValueLabel)
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIApplication.screenSize.height * 0.3 * 0.25),
            background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            mealImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            mealImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mealImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mealImage.widthAnchor.constraint(greaterThanOrEqualToConstant: 90),
            mealImage.heightAnchor.constraint(equalTo: mealImage.widthAnchor),
            
            mealTitleLabel.topAnchor.constraint(equalTo: mealImage.bottomAnchor, constant: 12),
            mealTitleLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 10),
            mealTitleLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -10),
            
            timeValueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            timeValueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            
            timeTag.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            timeTag.bottomAnchor.constraint(equalTo: timeValueLabel.topAnchor, constant: -10),
        ])
    }
    
    func setData(mealImage: UIImage, title: String) {
        self.mealImage.image = mealImage
        self.mealTitleLabel.text = title
    }
    
    
}
