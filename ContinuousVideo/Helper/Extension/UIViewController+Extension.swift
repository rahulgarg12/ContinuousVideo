//
//  UIViewController+Extension.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 12/11/20.
//

import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
}
