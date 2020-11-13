//
//  PlayerViewController.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 13/11/20.
//

import UIKit

final class PlayerViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet private weak var backButtonView: UIView! {
        didSet {
            backButtonView.layer.cornerRadius = backButtonView.bounds.width/2
            backButtonView.clipsToBounds = true
        }
    }
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(cellType: PlayerCollectionCell.self)
            collectionView.isPagingEnabled = true
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    
    // MARK: Enum
    private enum VisibleCellsOperation {
        case play
        case pause
    }
    
    
    // MARK: Properties
    var viewModel: PlayerViewModel!

    
    // MARK: Overridden Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        scrollToSelectedItem()
    }
    
    deinit {
        //for some reason, sometimes the audio still plays even if view is dismissed.
        for cell in collectionView.visibleCells {
            (cell as? PlayerCollectionCell)?.avPlayer?.pause()
        }
    }
    
    
    //MARK: Private Helpers
    private func initNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    private func scrollToSelectedItem() {
        DispatchQueue.main.async() {
            guard self.collectionView.numberOfItems(inSection: 0) > self.viewModel.currentItem else { return }
            
            let indexPath = IndexPath(item: self.viewModel.currentItem, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    private func playNext(indexPath: IndexPath) {
        let cellItemCount = collectionView.numberOfItems(inSection: 0)
        let nextItem = indexPath.item + 1
        if cellItemCount == nextItem {
            dismissView()
        } else if cellItemCount > nextItem {
            let nextIndexPath = IndexPath(item: nextItem, section: 0)
            collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    private func dismissView() {
        navigationController?.popViewController(animated: true)
    }
    
    private func performOnVisibleCells(operation: VisibleCellsOperation) {
        for cell in collectionView.visibleCells {
            let avPlayer = (cell as? PlayerCollectionCell)?.avPlayer
            switch operation {
            case .play: avPlayer?.play()
            case .pause: avPlayer?.pause()
            }
        }
    }
    
    
    //MARK: IBAction
    @IBAction private func didTapBack(_ sender: UIButton) {
        dismissView()
    }
}


//MARK: - ScrollView
extension PlayerViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        performOnVisibleCells(operation: .pause)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        performOnVisibleCells(operation: .play)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        performOnVisibleCells(operation: .play)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension PlayerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? PlayerCollectionCell)?.avPlayer?.play()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = viewModel.getCell(collectionView, at: indexPath)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? PlayerCollectionCell)?.avPlayer?.pause()
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension PlayerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}


// MARK: - PlayerCollectionCellDelegate
extension PlayerViewController: PlayerCollectionCellDelegate {
    func playerDidFinishPlaying(at indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        
        playNext(indexPath: indexPath)
    }
}
