//
//  ListViewCollectionTableCellViewModel.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 13/11/20.
//

import Foundation

final class ListViewCollectionTableCellViewModel {
    // MARK: Properties
    var nodes: [NodeModel]?
    
    private let pendingOperations = PendingOperations()
    
    
    // MARK: Computed Properties
    var itemCount: Int? {
        return nodes?.count
    }
    
    
    // MARK: Initialisers
    init(nodes: [NodeModel]) {
        self.nodes = nodes
    }
    
    
    // MARK: Helper Methods
    func fetchImage(video: VideoModel, at indexPath: IndexPath, completion: @escaping () -> Void) {
        ImageHelper.getImageFromCache(for: video.encodeUrl) { (image) in
            if let image = image {
                video.image = image
                video.state = .downloaded
                completion()
            } else {
                let downloader = ThumbnailDownloader(videoModel: video)
                downloader.completionBlock = {
                    guard !downloader.isCancelled else { return }
                    
                    self.pendingOperations.downloads.removeValue(forKey: indexPath)
                    
                    if video.state == .downloaded, let image = video.image {
                        ImageHelper.storeIntoCache(image: image, key: video.encodeUrl)
                    }
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                }
                
                self.pendingOperations.downloads[indexPath] = downloader
                self.pendingOperations.downloadQueue.addOperation(downloader)
            }
        }
    }
    
    
    // MARK: Table Helpers
    func didEndDisplayingCell(at indexPath: IndexPath) {
        pendingOperations.downloads[indexPath]?.cancel()
        pendingOperations.downloads.removeValue(forKey: indexPath)
    }
    
    func prefetchItems(at indexPaths: [IndexPath]) {
        guard let nodes = nodes else { return }
        
        for indexPath in indexPaths {
            guard nodes.count > indexPath.item else { continue }
            
            let urlString = nodes[indexPath.item].video.encodeUrl
            ImageHelper.getImageFromCache(for: urlString) { (image) in
                guard image == nil,
                      let url = URL(string: urlString)
                    else { return }

                DispatchQueue.global().async {
                    guard let image = ImageHelper.getThumbnailImage(from: url) else { return }

                    ImageHelper.storeIntoCache(image: image, key: url.absoluteString)
                }
            }
        }
    }
}
