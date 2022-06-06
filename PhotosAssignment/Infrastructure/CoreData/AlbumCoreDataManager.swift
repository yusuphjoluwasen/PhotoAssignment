//
//  AlbumCoreDataManager.swift
//  PhotosAssignment
//
//  Created by Guru on 02/06/2022.
//

import Foundation


class AlbumCoreDataManager{
    static let CDAlbumEntity = String(describing:Album.self)

    class func save(albums:[AlbumModel]){
        for album in albums{
            let cdAlbum:Album = CoreDataStack.getObjectFor(entityName: CDAlbumEntity) as! Album
            cdAlbum.id = "\(album.id ?? 0)"
            cdAlbum.title = album.title
            cdAlbum.savedTime = Date().timeIntervalSinceReferenceDate
        }
        CoreDataStack.saveContext()
    }
    
    class func clearAlbumData(){
        CoreDataStack.clearAllData(entityName: CDAlbumEntity)
    }

    class func getAlbums()->[Album]{
        return CoreDataStack.loadData(entityName: CDAlbumEntity, predicate: nil)
    }
}
