//
//  UICollectionView+Extension.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 12/11/20.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
        return cell
    }
}

