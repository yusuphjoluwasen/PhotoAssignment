//
//  MockPhotoRepository.swift
//  PhotosAssignmentTests
//
//  Created by Guru on 05/06/2022.
//

import Foundation
@testable import PhotosAssignment
import RxSwift

final class MockPhotoRepository:PhotoRepositoryDelegate{
    let disposeBag = DisposeBag()
    
    func fetchPhotoData(page:Int, albumId:Int) -> Observable<([PhotoModel]?, String?)>{
        let factory = MockPhotoRepositoryFactory()
        return factory.fetchData(request: nil)
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
}
