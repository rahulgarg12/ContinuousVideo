//
//  DataModel.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 12/11/20.
//

import Foundation

struct DataModel: Codable {
    let title: String
    let nodes: [NodeModel]
}
