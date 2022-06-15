//
//  AlbumViewModel.swift
//  PhotosAssignment
//
//  Created by Guru on 02/06/2022.
//

import RxSwift
import UIKit

final class AlbumViewModel:AlbumListViewModelProtocol{
    var coordinatorDelegate: PhotosCoordinatorDelegate?
    weak var delegate: AlbumViewControllerDelegate?
    let pagination = PaginationApiClass<AlbumDto>()
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
        repository.provideData { [weak self] in
            guard let self = self else{ return }
            self.delegate?.setLoading(true)
        } completion: { [weak self] albums, error in
            guard let self = self else{ return }
            self.delegate?.setLoading(false)
            self.updateUI(albums,error)
        }
    }
    
    func updateUI(_ albums:[AlbumDto]?, _ error:String?){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let error = error{
                self.error = error
            }
            if let albums = albums{
                self.albumList = albums
            }
        }
    }
    
    func initViewSetup(){
        delegate?.setUpTitle()
        delegate?.setUpRefresh()
        delegate?.reloadCollection()
    }
    
    func getDataSource(_ tableView:UITableView) -> AlbumDataSource {
        let didSelectItemHandler : AlbumDataSource.AlbumDidSelectItemHandler = {  [weak self] index in
            self?.getAlbumItem(at: index)
        }
        
        let scrollToTheEndHandler : AlbumDataSource.ScrollToTheEndHandler = {  [weak self] in
            self?.onScrollToTheEnd()
        }
        
        return AlbumDataSource(albumList,tableView,didSelectItemHandler,scrollToTheEndHandler)
    }
    
    func onScrollToTheEnd() {
        pagination.fetch { [weak self] in
            guard let self = self else{ return }
            self.pagination.incrementPageNumber()
            self.delegate?.onFetchingMoreData()
            self.repository.fetchAndUpdate(page: self.pagination.pageNum) { albums, error in
                DispatchQueue.main.async {
                    self.updateUI(albums,error)
                    self.delegate?.doneFetchingMoreData()
                    self.pagination.stopFetching(albums ?? [])
                    
                }
            }
        }
    }
    
    func getAlbumItem(at index: Int) {
        let id = albumList[index].id
        coordinatorDelegate?.showPhotos(of: id)
    }
    
    func refresh() {
        pagination.resetPageNumber()
        repository.fetchAndSave(page: pagination.pageNum) { [weak self] albums, error in
            guard let self = self else{ return }
            DispatchQueue.main.async {
                self.updateUI(albums,error)
                self.delegate?.doneRefreshing()
                self.updateUI(albums, error)
            }
        }
    }
}
