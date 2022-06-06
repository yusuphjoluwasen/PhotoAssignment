//
//  Api.swift
//  PhotosAssignment
//
//  Created by Guru on 04/06/2022.
//

import Foundation

enum AlbumApi{
    case album(params: [String:String]?)
    case photos(params: [String:String]?)
}

extension AlbumApi:EndpointType{
    var baseURL: String {
        return Constants.AlbumApi.baseurl
    }
    
    var path: String {
        switch self {
        case .album:
            return Constants.AlbumApi.albums
        case .photos:
            return Constants.AlbumApi.photos
        }
    }
    
    var constructedURL: String{
        switch self {
        case .album, .photos:
            return self.baseURL + self.path
        }
    }
    
    var params: [String:String]? {
        switch self {
        case .album(let params):
            return params
        case .photos(let params):
            return params
        }
    }
}
