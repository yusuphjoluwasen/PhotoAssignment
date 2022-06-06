//
//  RepositoryTest.swift
//  EvaluationTests
//
//  Created by Guru on 29/05/2022.
//

@testable import PhotosAssignment
import RxSwift

final class MockAlbumRepository:AlbumRepositoryDelegate{
    func fetchAlbumData(page: Int) -> Observable<([AlbumModel]?, String?)> {
        let factory = MockAlbumRepositoryFactory()
        return factory.fetchData(request: nil)
    }
}
