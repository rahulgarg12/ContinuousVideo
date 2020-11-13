//
//  UITableViewCell+Extension.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 13/11/20.
//

import UIKit

extension UITableViewCell {
    var tableView: UITableView? {
        return next(of: UITableView.self)
    }
    
    var indexPath: IndexPath? {
        return tableView?.indexPath(for: self)
    }
}
