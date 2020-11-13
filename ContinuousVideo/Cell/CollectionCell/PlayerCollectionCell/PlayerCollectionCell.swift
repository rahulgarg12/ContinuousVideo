//
//  PlayerCollectionCell.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 13/11/20.
//

import UIKit
import AVFoundation
import AVKit

protocol PlayerCollectionCellDelegate: class {
    func playerDidFinishPlaying(at indexPath: IndexPath?)
}


final class PlayerCollectionCell: UICollectionViewCell {
    
    // MARK: Properties
    weak var delegate: PlayerCollectionCellDelegate?
    
    var avPlayer: AVPlayer?
    var avPlayerLayer: AVPlayerLayer?
    
    var video: VideoModel? {
        didSet {
            guard let urlString = video?.encodeUrl,
                  let videoURL = URL(string: urlString)
                else { return }
            
            avPlayerLayer?.removeFromSuperlayer()
            
            initPlayer(with: videoURL)
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(playerDidFinishPlaying(_:)),
                                                   name: .AVPlayerItemDidPlayToEndTime,
                                                   object: nil)
        }
    }
           
    
    // MARK: Private Helpers
    private func initPlayer(with videoURL: URL) {
        avPlayer = AVPlayer(url: videoURL)
        avPlayerLayer = AVPlayerLayer(player: avPlayer!)
        avPlayerLayer?.videoGravity = .resizeAspectFill
        avPlayerLayer?.frame = bounds
        layer.addSublayer(avPlayerLayer!)
    }
    
    
    // MARK: Selectors
    @objc private func playerDidFinishPlaying(_ sender: Notification) {
        delegate?.playerDidFinishPlaying(at: indexPath)
    }
}
