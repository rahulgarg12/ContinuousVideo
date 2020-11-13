//
//  ImageCollectionCell.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 12/11/20.
//

import UIKit

final class ImageCollectionCell: UICollectionViewCell {
    // MARK: IBOutlets
    @IBOutlet private weak var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.contentMode = .scaleAspectFill
            thumbnailImageView.layer.cornerRadius = 8
            thumbnailImageView.clipsToBounds = true
        }
    }
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.startAnimating()
        }
    }
    
    
    // MARK: Properties
    var video: VideoModel? {
        didSet {
            set(image: video?.image)
            hideActivityIndicator()
        }
    }
    
    
    // MARK: Helpers
    func set(image: UIImage?) {
        thumbnailImageView.image = image
    }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
