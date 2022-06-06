//
//  AlbumRepository.swift
//  PhotosAssignment
//
//  Created by Guru on 02/06/2022.
//

import Foundation
import RxSwift

protocol AlbumRepositoryDelegate {
    func fetchAlbumData(page:Int) -> Observable<([AlbumModel]?, String?)>
}

class AlbumRepository:AlbumRepositoryDelegate{
    
    let factory:RepositoryFactoryDelegate
    
    init(factory:RepositoryFactoryDelegate) {
        self.factory = factory
    }

    func fetchAlbumData(page:Int) -> Observable<([AlbumModel]?, String?)> {
        let endPoint = AlbumApi.album(params: ["_page" : "\(page)"])
        return factory.fetchData(request: endPoint)
    }
}
