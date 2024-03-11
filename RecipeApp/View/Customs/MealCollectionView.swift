//
//  MealCollectionView.swift
//  RecipeApp
//
//  Created by Timur Baimukhambet on 18.01.2024.
//

import UIKit

class MealCollectionView: UICollectionView {

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        super.init(frame: .zero, collectionViewLayout: layout)
        self.showsHorizontalScrollIndicator = false
        self.register(MealCell.self, forCellWithReuseIdentifier: MealCell.description())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
