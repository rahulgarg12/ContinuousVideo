//
//  Theme.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 16/11/20.
//

import UIKit

@propertyWrapper
struct Theme {
    let light: UIColor
    let dark: UIColor
    
    var wrappedValue: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return dark
                } else {
                    return light
                }
            }
        } else {
            return light
        }
    }
}
