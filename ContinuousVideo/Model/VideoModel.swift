//
//  VideoModel.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 12/11/20.
//

import UIKit

enum ImageRecordState {
    case new
    case downloaded
    case failed
}

final class VideoModel: Codable {
    let encodeUrl: String
    
    var state: ImageRecordState = .new
    var image: UIImage?
    
    private enum CodingKeys: String, CodingKey {
        case encodeUrl
    }
}
