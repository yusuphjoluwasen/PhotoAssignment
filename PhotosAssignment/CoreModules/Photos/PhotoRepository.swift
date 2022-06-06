//
//  PhotoRepository.swift
//  PhotosAssignment
//
//  Created by Guru on 01/06/2022.
//

import Foundation
import RxSwift

protocol PhotoRepositoryDelegate {
    func fetchPhotoData(page:Int, albumId:Int) -> Observable<([PhotoModel]?, String?)>
}

class PhotoRepository:PhotoRepositoryDelegate{
    
    let factory:RepositoryFactoryDelegate
    
    init(factory:RepositoryFactoryDelegate) {
        self.factory = factory
    }

    func fetchPhotoData(page:Int, albumId:Int) -> Observable<([PhotoModel]?, String?)> {
        let endPoint = AlbumApi.photos(params: ["album" : "\(albumId)", "_page" : "\(page)"])
        return factory.fetchData(request: endPoint)
    }
}
