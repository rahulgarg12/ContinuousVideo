//
//  ClassNameProtocol.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 12/11/20.
//

protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}
