//
//  AlbumViewModel+Data.swift
//  PhotosAssignment
//
//  Created by Guru on 04/06/2022.
//

import Foundation
extension AlbumViewModel{
    func fetchDataFromDB()-> [Album]{
        AlbumCoreDataManager.getAlbums()
    }
    
    func saveDataToDB(albums: [AlbumModel]){
        AlbumCoreDataManager.clearAlbumData()
        saveToDB(albums: albums)
    }
    
    func updateAlbumInDB(albums: [AlbumModel]){
        saveToDB(albums: albums)
    }
    
    func saveToDB(albums: [AlbumModel]){
        AlbumCoreDataManager.save(albums: albums)
    }
    
    func updateAlbumDto(albums: [AlbumModel]){
        albumList = mapAlbumDataToDto(data: albums)
    }
    
    func updateAlbumDto(albums: [Album]){
        albumList = mapAlbumDataToDto(data: albums)
    }
    
    func updateDtoAfterDBUpdate(){
        let albums = fetchDataFromDB()
        albumList = mapAlbumDataToDto(data: albums)
    }
    
    func mapAlbumDataToDto(data:[AlbumModel]) -> [AlbumDto]{
        return data.map{ album in
            let id = album.id
            return AlbumDto(id: id.toInt, title: album.title ?? "")
        }
    }
    
    func mapAlbumDataToDto(data:[Album]) -> [AlbumDto]{
        return data.map{ album in
            let id = album.id?.toInt()
            return AlbumDto(id: id.toInt, title: album.title ?? "")
        }
    }
}
