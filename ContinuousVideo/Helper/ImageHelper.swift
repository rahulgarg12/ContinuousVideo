//
//  ImageHelper.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 13/11/20.
//

import UIKit
import Kingfisher
import AVFoundation

final class ImageHelper {
    static func storeIntoCache(image: UIImage, key: String) {
        return ImageCache.default.store(image, forKey: key)
    }
    
    static func getImageFromCache(for key: String?, completion: @escaping (UIImage?) -> ()) {
        guard let key = key else {
            completion(nil)
            return
        }
        
        ImageCache.default.retrieveImage(forKey: key) { result in
            switch result {
            case .success(let value):
                completion(value.image)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    static func getThumbnailImage(from url: URL) -> UIImage? {
        let asset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1000), actualTime: nil)
            let image = UIImage(cgImage: thumbnailImage)
            return image
        } catch {
            return nil
        }
    }
}
