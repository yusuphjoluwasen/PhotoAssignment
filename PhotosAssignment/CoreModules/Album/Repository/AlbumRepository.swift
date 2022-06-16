//
//  AlbumRepository.swift
//  PhotosAssignment
//
//  Created by Guru on 02/06/2022.
//

import Foundation
import RxSwift

typealias AlbumModelHandler = (([AlbumModel]?, String?) -> Void)
typealias AlbumDtoHandler = (([AlbumDto]?, String?) -> Void)

protocol AlbumRepositoryDelegate {
    func provideData(loading:() -> Void, completion: @escaping AlbumDtoHandler)
    func fetchAndSave(page:Int, completion:@escaping AlbumDtoHandler)
    func fetchAndUpdate(page: Int, completion: @escaping AlbumDtoHandler)
}

final class AlbumRepository:AlbumRepositoryDelegate {
    let disposeBag = DisposeBag()
    
    let api:AlbumApiDelegate
    let transform:AlbumTransformationDelegate
    let db:AlbumDBDelegate
    
    init(api:AlbumApiDelegate, transform:AlbumTransformationDelegate,  db:AlbumDBDelegate) {
        self.api = api
        self.transform = transform
        self.db = db
    }
    
    func provideData(loading: () -> Void, completion: @escaping AlbumDtoHandler) {
        let data = db.fetchDataFromDB()
        guard data.count > 0 else {
            loading()
            fetchAndSave(page: Constants.Dim.one, completion: completion)
            return
        }
        completion(transform.mapAlbumDataToDto(data: data), nil)
    }
    
    func fetchAndUpdate(page: Int,completion: @escaping AlbumDtoHandler) {
        fetchDataFromNetwork(page: page) { [weak self] data, err in
            guard let self = self else { return }
            resolveResponse(data,err) { albums, err in
                self.db.updateDB(albums: albums ?? [])
                let datafromdb = self.db.fetchDataFromDB()
                let dto = self.transform.mapAlbumDataToDto(data: datafromdb)
                completion(dto, err)
            }
        }
    }
    
    func fetchAndSave(page: Int, completion: @escaping AlbumDtoHandler) {
        fetchDataFromNetwork(page: page) { [weak self] data, err in
            guard let self = self else { return }
            resolveResponse(data,err) { albums, err in
                self.db.clearAndSaveToDB(albums: albums ?? [])
                let dto = self.transform.mapAlbumDataToDto(data: albums ?? [])
                completion(dto, err)
            }
        }
    }
    
    private func fetchDataFromNetwork(page:Int, completion:@escaping AlbumModelHandler){
        api.fetchDataFromApi(page:page).subscribe(onNext: { data, err in
            resolveResponse(data, err, completion)
        }).disposed(by: disposeBag)
    }
}


