//
//  UIFont+Theme.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 28/11/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func rounded(fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: weight)

        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            return UIFont(descriptor: descriptor, size: fontSize)
        }
        
        return systemFont
    }
    
}
