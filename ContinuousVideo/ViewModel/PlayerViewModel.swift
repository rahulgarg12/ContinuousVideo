//
//  PlayerViewModel.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 13/11/20.
//

import UIKit

final class PlayerViewModel {
    // MARK: Properties
    var nodes: [NodeModel]?
    var currentItem = 0
    
    
    // MARK: Computed Properties
    var itemCount: Int? {
        return nodes?.count
    }
    
    
    // MARK: Initialisers
    init(nodes: [NodeModel]?, currentItem: Int) {
        self.nodes = nodes
        self.currentItem = currentItem
    }
    
    
    // MARK: Table Helpers
    func getCell(_ collectionView: UICollectionView, at indexPath: IndexPath) -> PlayerCollectionCell {
        let cell = collectionView.dequeueReusableCell(with: PlayerCollectionCell.self, for: indexPath)
        if let nodes = nodes, nodes.count > indexPath.item {
            cell.video = nodes[indexPath.item].video
        }
        return cell
    }
}
