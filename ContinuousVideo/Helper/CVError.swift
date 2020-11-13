//
//  CVError.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 13/11/20.
//

enum CVError: Error {
    case error(Error)
    case localizedDescription(String)
    
    case jsonFileNotFound
    case jsonParsing
    case generic
    
    var error: Error? {
        switch self {
        case .error(let error):
            return error
        default:
            return nil
        }
    }
    
    var localizedDescription: String {
        return description.localizedUppercase
    }
    
    var description: String {
        switch self {
        case .error(let error):
            return error.localizedDescription
        case .localizedDescription(let message):
            return message
        case .jsonFileNotFound:
            return Constants.CVErrorMessage.jsonFileNotFound
        case .jsonParsing:
            return Constants.CVErrorMessage.jsonParsing
        default:
            return Constants.CVErrorMessage.generic
        }
    }
}
