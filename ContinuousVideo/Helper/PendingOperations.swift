//
//  PendingOperations.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 13/11/20.
//

import Foundation

final class PendingOperations {
    lazy var downloads: [IndexPath: Operation] = [:]
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "DownloadQueue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}
