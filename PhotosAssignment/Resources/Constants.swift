//
//  Constants.swift
//  Evaluation
//
//  Created by Guru on 28/05/2022.
//

enum Constants {
    enum AlbumApi{
        static let baseurl = "http://testapi.pinch.nl:3000/"
        static let albums = "albums"
        static let photos = "photos"
    }
    
    enum Nav {
        static let album = "Album List"
        static let photos = "Photos"
        static let photodetail = "Photo Detail"
    }
    
    enum StoryboardIdentifiers {
        static let album = "AlbumVc"
        static let photodetail = "PhotoDetail"
    }
    
    enum Cell {
        static let album = "albumcell"
    }
    
    enum Other {
        static let placeholder = "thumbnail"
        static let refreshtitle = "Pull to refresh"
    }
    
    enum Dim {
        static let one = 1
        static let two = 2
        static let three = 3
        static let five = 5
        static let ten = 10
        static let hundred = 100
    }
}


