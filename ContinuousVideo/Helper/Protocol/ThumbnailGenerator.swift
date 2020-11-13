//
//  ThumbnailGenerator.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 13/11/20.
//

import UIKit
import AVFoundation

protocol ThumbnailGenerator {
    func setThumbnailImage(from urlString: String?, on imageView: UIImageView?)
}

extension ThumbnailGenerator {
    func setThumbnailImage(from urlString: String?, on imageView: UIImageView?) {
        guard let urlString = urlString,
              let url = URL(string: urlString)
            else { return }
        
        DispatchQueue.global().async {
            guard let image = ImageHelper.getThumbnailImage(from: url) else { return }
            
            ImageHelper.storeIntoCache(image: image, key: url.absoluteString)
            
            DispatchQueue.main.async {
                imageView?.image = image
            }
        }
    }
}
