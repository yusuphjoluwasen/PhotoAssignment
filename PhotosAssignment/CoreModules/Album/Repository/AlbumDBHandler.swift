//
//  AlbumDBHandler.swift
//  PhotosAssignment
//
//  Created by Guru on 07/06/2022.
//

import Foundation

protocol AlbumDBDelegate {
    func fetchDataFromDB()-> [Album]
    func saveToDB(albums: [AlbumModel])
    func clearAndSaveToDB(albums: [AlbumModel])
    func updateDB(albums: [AlbumModel])
}

final class AlbumDBHandler:AlbumDBDelegate{
    func fetchDataFromDB()-> [Album]{
        AlbumCoreDataManager.getAlbums()
    }
    
    func clearAndSaveToDB(albums: [AlbumModel]){
        AlbumCoreDataManager.clearAlbumData()
        saveToDB(albums: albums)
    }
    
    func updateDB(albums: [AlbumModel]){
        saveToDB(albums: albums)
    }
    
    func saveToDB(albums: [AlbumModel]){
        AlbumCoreDataManager.save(albums: albums)
    }
}
