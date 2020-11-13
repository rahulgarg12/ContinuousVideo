//
//  ThumbnailDownloader.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 13/11/20.
//

import UIKit

final class ThumbnailDownloader: Operation {
    let videoModel: VideoModel
    
    init(videoModel: VideoModel) {
        self.videoModel = videoModel
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        if let url = URL(string: videoModel.encodeUrl), let image = ImageHelper.getThumbnailImage(from: url) {
            videoModel.state = .downloaded
            videoModel.image = image
        } else {
            videoModel.state = .failed
        }
    }
}
