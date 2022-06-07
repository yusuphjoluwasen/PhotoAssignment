//
//  AlbumApiHandler.swift
//  PhotosAssignment
//
//  Created by Guru on 07/06/2022.
//

import Foundation
import RxSwift

protocol AlbumApiDelegate {
    func fetchDataFromApi(page:Int) -> Observable<([AlbumModel]?, String?)>
}

class AlbumAPiHandler:AlbumApiDelegate{
    let factory:RepositoryFactoryDelegate
    
    init(factory:RepositoryFactoryDelegate) {
        self.factory = factory
    }
    
    func fetchDataFromApi(page:Int) -> Observable<([AlbumModel]?, String?)> {
        let endPoint = AlbumApi.album(params: ["_page" : "\(page)"])
        return factory.fetchData(request: endPoint)
    }
}
