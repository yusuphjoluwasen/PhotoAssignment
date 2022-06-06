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
    func fetchPhotoData(page:Int, albumId:Int) -> Observable<([PhotoModel]?, String?)>{
        let factory = MockPhotoRepositoryFactory()
        return factory.fetchData(request: nil)
    }
}
