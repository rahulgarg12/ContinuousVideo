//
//  Constants.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 13/11/20.
//

import UIKit

struct Constants {
    struct Title {
        static let listViewContollerTitle = "Explore"
    }
    
    struct CVErrorMessage {
        static let jsonFileNotFound = "JSON file couldn't be found"
        static let jsonParsing = "JSON couldn't be parsed"
        static let generic = "Something went wrong"
    }
    
    struct Space {
        static let imageCarouselBottomInset: CGFloat = 25
        static let imageCarouselInteritem: CGFloat = 20
        static let imageCarouselHeight: CGFloat = 150
        static let imageCarouselWidth: CGFloat = 100
    }
}
