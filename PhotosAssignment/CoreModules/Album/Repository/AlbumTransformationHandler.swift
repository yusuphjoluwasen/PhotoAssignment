//
//  AlbumTransformationHandler.swift
//  PhotosAssignment
//
//  Created by Guru on 07/06/2022.
//

protocol AlbumTransformationDelegate {
    func mapAlbumDataToDto(data:[AlbumModel]) -> [AlbumDto]
    func mapAlbumDataToDto(data:[Album]) -> [AlbumDto]
}

class AlbumTransformationHandler:AlbumTransformationDelegate{
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
