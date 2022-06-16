//
//  RepositoryTest.swift
//  EvaluationTests
//
//  Created by Guru on 29/05/2022.
//

@testable import PhotosAssignment
import RxSwift

final class MockAlbumRepository:AlbumRepositoryDelegate{
    let disposeBag = DisposeBag()
    
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
    
    func fetchDataFromApi(page: Int) -> Observable<([AlbumModel]?, String?)> {
        let factory = MockAlbumRepositoryFactory()
        return factory.fetchData(request: nil)
    }
    
    func provideData(loading: () -> Void, completion: @escaping AlbumDtoHandler) {
        fetchDataFromNetwork(page:1, completion:{ [weak self] data, err in
            resolveResponse(self?.mapAlbumDataToDto(data: data!), err, completion)
        })
    }
    
    func fetchAndSave(page: Int, completion: @escaping AlbumDtoHandler) {
        
    }
    
    func fetchAndUpdate(page: Int, completion: @escaping AlbumDtoHandler) {
        
    }
    
    private func fetchDataFromNetwork(page:Int, completion:@escaping AlbumModelHandler){
        fetchDataFromApi(page:page).subscribe(onNext: { data, err in
            resolveResponse(data, err, completion)
        }).disposed(by: disposeBag)
    }
}


