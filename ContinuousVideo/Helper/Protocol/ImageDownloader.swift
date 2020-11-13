//
//  ImageDownloader.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 13/11/20.
//

import UIKit
import Kingfisher

protocol ImageDownloader {
    func setImage(on imageView: UIImageView, image: String?, placeholder: UIImage?)
}

extension ImageDownloader {
    func setImage(on imageView: UIImageView, image: String?, placeholder: UIImage?) {
        if let imageString = image, let imageUrl = URL(string: imageString) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: imageUrl, placeholder: placeholder)
        } else {
            imageView.image = placeholder
        }
    }
}
