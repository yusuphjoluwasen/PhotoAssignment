//
//  AlbumViewModel.swift
//  PhotosAssignment
//
//  Created by Guru on 02/06/2022.
//

import Foundation
import RxSwift
import CoreAudio

class AlbumViewModel:AlbumListViewModelProtocol{
    var coordinatorDelegate: PhotosCoordinatorDelegate?
    weak var delegate: AlbumViewControllerDelegate?
    let pagination = PaginationApiClass<AlbumModel>()
    var getTitle: String { Constants.Nav.album }
    var getCellIndentifier: String { Constants.Cell.album }
    var refreshTitle: String { Constants.Other.refreshtitle }
    let disposeBag = DisposeBag()
    private let repository:AlbumRepositoryDelegate
    
    init(repository:AlbumRepositoryDelegate) {
        self.repository = repository
    }
    
    var albumList:[AlbumDto] = []{
        didSet{
            delegate?.reloadCollection()
        }
    }
    
    var error:String?{
        didSet{
            delegate?.sendError(error: error.toString)
        }
    }
    
    func load(){
        initViewSetup()
        let db = fetchDataFromDB()
        guard db.count > 0 else {
            delegate?.setLoading(true)
            fetchDataFromNetwork(page: pagination.pageNum, action: { [weak self] albums in
                guard let self = self else{ return }
                self.delegate?.setLoading(false)
                self.saveDataToDB(albums: albums)
                self.updateAlbumDto(albums: albums)
            })
            return
        }
        updateAlbumDto(albums: db)
    }
    
    func initViewSetup(){
        delegate?.setUpTitle()
        delegate?.setUpRefresh()
        delegate?.reloadCollection()
    }
    
    func getDataSource() -> AlbumDataSource {
        return AlbumDataSource(albums: albumList)
    }
    
    func onScrollToTheEnd() {
        pagination.fetch { [weak self] in
            guard let self = self else{ return }
            self.pagination.incrementPageNumber()
            self.delegate?.onFetchingMoreData()
            self.fetchDataFromNetwork(page: self.pagination.pageNum) { albums in
                self.updateAlbumInDB(albums: albums)
                self.updateDtoAfterDBUpdate()
                self.delegate?.doneFetchingMoreData()
                self.pagination.stopFetching(albums)
            }
        }
    }
    
    func getAlbumItem(at index: Int) {
        let id = albumList[index].id
        coordinatorDelegate?.showPhotos(of: id)
    }
    
    func refresh() {
        pagination.resetPageNumber()
        fetchDataFromNetwork(page: pagination.pageNum) { [weak self] albums in
            guard let self = self else{ return }
            self.delegate?.doneRefreshing()
            self.saveDataToDB(albums: albums)
            self.updateDtoAfterDBUpdate()
        }
    }
    
    private func fetchDataFromNetwork(page:Int, action:@escaping (([AlbumModel]) -> Void)){
        repository.fetchAlbumData(page:page).subscribe(onNext: { [weak self] data, err in
            guard let self = self else{ return }
            DispatchQueue.main.async {
                if let albums = data{
                    action(albums)
                }
                
                if let error = err{
                    self.error = error
                }
            }
        }).disposed(by: disposeBag)
    }
}
