//
//  UIImageViewExt.swift
//  RecipeApp
//
//  Created by Timur Baimukhambet on 28.01.2024.
//

import UIKit

class RoundUIImageView: UIImageView {
//    init() {
//        super.init(frame: .zero)
//        self.layer.cornerRadius = self.bounds.width / 2
//        self.clipsToBounds = true
//        self.layer.masksToBounds = true
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.bounds.width / 2
        self.clipsToBounds = true
        
    }
}
