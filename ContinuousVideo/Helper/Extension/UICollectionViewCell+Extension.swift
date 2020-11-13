//
//  UICollectionViewCell+Extension.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 13/11/20.
//

import UIKit

extension UICollectionViewCell {
    var collectionView: UICollectionView? {
        return next(of: UICollectionView.self)
    }
    
    var indexPath: IndexPath? {
        return collectionView?.indexPath(for: self)
    }
}
