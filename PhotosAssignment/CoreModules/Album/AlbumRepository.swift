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

protocol PrivateAlbumDBRepositoryDelegate {
    func fetchDataFromApi(page:Int) -> Observable<([AlbumModel]?, String?)>
    func fetchDataFromDB()-> [Album]
    func saveToDB(albums: [AlbumModel])
    func clearAndSaveToDB(albums: [AlbumModel])
    func updateDB(albums: [AlbumModel])
}

protocol AlbumTransformRepositoryDelegate {
    func mapAlbumDataToDto(data:[AlbumModel]) -> [AlbumDto]
    func mapAlbumDataToDto(data:[Album]) -> [AlbumDto]
}

protocol PrivateAlbumApiRepositoryDelegate {
    func fetchDataFromApi(page:Int) -> Observable<([AlbumModel]?, String?)>
}

protocol AlbumRepositoryDelegate {
    func provideData(loading:@escaping () -> Void, completion: @escaping AlbumDtoHandler)
    func fetchAndSave(page:Int, completion:@escaping AlbumDtoHandler)
    func fetchAndUpdate(page: Int,_ loading:(() -> Void)?, completion: @escaping AlbumDtoHandler)
}

final class AlbumRepository:AlbumRepositoryDelegate & PrivateAlbumDBRepositoryDelegate & PrivateAlbumApiRepositoryDelegate & AlbumTransformRepositoryDelegate{
    
    let disposeBag = DisposeBag()
    let factory:RepositoryFactoryDelegate
    
    init(factory:RepositoryFactoryDelegate) {
        self.factory = factory
    }
    
    func provideData(loading: () -> Void, completion: @escaping AlbumDtoHandler) {
        let data = fetchDataFromDB()
        guard data.count > 0 else {
            loading()
            fetchAndSave(page: Constants.Dim.one, completion: completion)
            return
        }
        completion(mapAlbumDataToDto(data: data), nil)
    }
    
    //MARK: Api
    func fetchAndUpdate(page: Int,_ loading: (() -> Void)?, completion: @escaping AlbumDtoHandler) {
        (loading ?? doNothing)()
        fetchDataFromNetwork(page: page) { [weak self] data, err in
            guard let self = self else { return }
            resolveResponse(data,err) { albums, err in
                self.updateDB(albums: albums ?? [])
                let datafromdb = self.fetchDataFromDB()
                let dto = self.mapAlbumDataToDto(data: datafromdb)
                completion(dto, nil)
            }
        }
    }
    
    func fetchAndSave(page: Int, completion: @escaping AlbumDtoHandler) {
        fetchDataFromNetwork(page: page) { [weak self] data, err in
            guard let self = self else { return }
            resolveResponse(data,err) { albums, err in
                self.clearAndSaveToDB(albums: albums ?? [])
                let dto = self.mapAlbumDataToDto(data: albums ?? [])
                completion(dto, nil)
            }
        }
    }
    
    private func fetchDataFromNetwork(page:Int, completion:@escaping AlbumModelHandler){
        fetchDataFromApi(page:page).subscribe(onNext: { data, err in
            resolveResponse(data, err, completion)
        }).disposed(by: disposeBag)
    }
    
    func fetchDataFromApi(page:Int) -> Observable<([AlbumModel]?, String?)> {
        let endPoint = AlbumApi.album(params: ["_page" : "\(page)"])
        return factory.fetchData(request: endPoint)
    }
    
    //MARK: Transformation
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
    
    //MARK: DB
    func fetchDataFromDB()-> [Album]{
        AlbumCoreDataManager.getAlbums()
    }
    
    func clearAndSaveToDB(albums: [AlbumModel]){
        AlbumCoreDataManager.clearAlbumData()
        saveToDB(albums: albums)
    }
    
    func updateDB(albums: [AlbumModel]){
        saveToDB(albums: albums)
    }
    
    func saveToDB(albums: [AlbumModel]){
        AlbumCoreDataManager.save(albums: albums)
    }
}


