//
//  ListViewCollectionTableCell.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 12/11/20.
//

import UIKit

protocol ListViewCollectionTableCellDelegate: class {
    func didTapCollectionVideo(at indexPath: IndexPath, nodes: [NodeModel]?)
}


final class ListViewCollectionTableCell: UITableViewCell {
    // MARK: IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.contentInset = UIEdgeInsets(top: 0,
                                                       left: Constants.Space.imageCarouselInteritem,
                                                       bottom: 0,
                                                       right: Constants.Space.imageCarouselInteritem)
            collectionView.backgroundColor = .secondarySystemBackground
            collectionView.register(cellType: ImageCollectionCell.self)
            collectionView.prefetchDataSource = self
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    
    // MARK: Properties
    weak var delegate: ListViewCollectionTableCellDelegate?
    var viewModel: ListViewCollectionTableCellViewModel?
    
    
    // MARK: Overridden Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ListViewCollectionTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.itemCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ImageCollectionCell.self, for: indexPath)
        
        if let nodes = viewModel?.nodes, nodes.count > indexPath.item {
            let video = nodes[indexPath.item].video
            
            switch video.state {
            case .new, .failed:
                cell.set(image: nil)
                cell.showActivityIndicator()
                
                viewModel?.fetchImage(video: video, at: indexPath) {
                    cell.video = video
                }
                
            case .downloaded:
                cell.video = video
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel?.didEndDisplayingCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapCollectionVideo(at: indexPath, nodes: viewModel?.nodes)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension ListViewCollectionTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.Space.imageCarouselWidth,
                      height: Constants.Space.imageCarouselHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.Space.imageCarouselInteritem
    }
}


// MARK: - UICollectionViewDataSourcePrefetching
extension ListViewCollectionTableCell: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        viewModel?.prefetchItems(at: indexPaths)
    }
}
