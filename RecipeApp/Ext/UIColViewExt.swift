//
//  UIColViewExt.swift
//  RecipeApp
//
//  Created by Timur Baimukhambet on 20.01.2024.
//

import UIKit


extension UICollectionView {
    var maxHeight: CGFloat {
        let insets = contentInset.top + contentInset.bottom
        return bounds.height + insets
    }
}
