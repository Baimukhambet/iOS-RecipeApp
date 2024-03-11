//
//  CustomTabBar.swift
//  RecipeApp
//
//  Created by Timur Baimukhambet on 29.01.2024.
//

import UIKit

class CustomTabBar: UITabBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView?
    {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }

        for member in subviews.reversed()
        {
                let subPoint = member.convert(point, from: self)
                guard let result = member.hitTest(subPoint, with: event)
                else { continue }
                return result
        }

        return nil
    }

}
