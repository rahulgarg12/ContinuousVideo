//
//  UITableView+Extension.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 12/11/20.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
        return cell
    }
}

