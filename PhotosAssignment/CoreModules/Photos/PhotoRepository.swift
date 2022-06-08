//
//  PhotoRepository.swift
//  PhotosAssignment
//
//  Created by Guru on 01/06/2022.
//

import Foundation
import RxSwift

protocol PhotoRepositoryDelegate {
    func fetch(page:Int, albumId:Int, completion:@escaping (([PhotoDto]?, String?) -> Void))
}

class PhotoRepository:PhotoRepositoryDelegate{
    let disposeBag = DisposeBag()
    
    let factory:RepositoryFactoryDelegate
    
    init(factory:RepositoryFactoryDelegate) {
        self.factory = factory
    }
    
    func fetch(page:Int, albumId:Int, completion:@escaping (([PhotoDto]?, String?) -> Void)){
        fetchPhotoData(page: page, albumId: albumId).subscribe(onNext: { [weak self] data, err in
            guard let self = self else { return }
            let photos = self.mapPhotoDataToDto(data: data!)
            resolveResponse(photos, err, completion)
        }).disposed(by: disposeBag)
    }
    
    func mapPhotoDataToDto(data:[PhotoModel]) -> [PhotoDto]{
        return data.map{ photo in
            PhotoDto(id: photo.id.toInt, title: photo.title.toString, imageUrl: photo.thumbnailUrl.toString)
        }
    }
    
    func fetchPhotoData(page:Int, albumId:Int) -> Observable<([PhotoModel]?, String?)> {
        let endPoint = AlbumApi.photos(params: ["album" : "\(albumId)", "_page" : "\(page)"])
        return factory.fetchData(request: endPoint)
    }
}
