//
//  PhotoViewModel.swift
//  PhotosAssignment
//
//  Created by Guru on 01/06/2022.
//

import Foundation
import RxSwift
import UIKit

class PhotoViewModel:PhotoViewModelProtocol{
    var coordinatorDelegate: PhotosCoordinatorDetailDelegate?
    weak var delegate: PhotoViewControllerDelegate?
    var getTitle: String { Constants.Nav.photos }
    var navTitleColor: UIColor { UIColor.black }
    var refreshTitle: String { Constants.Other.refreshtitle }
    let disposeBag = DisposeBag()
    let pagination = PaginationApiClass<PhotoModel>()
    private let albumId:Int
    private let repository:PhotoRepositoryDelegate
    
    init(repository:PhotoRepositoryDelegate,albumId:Int) {
        self.repository = repository
        self.albumId = albumId
    }
    
    var photoList:[PhotoDto] = []{
        didSet{
            delegate?.reloadCollection()
        }
    }
    
    var error:String?{
        didSet{
            delegate?.sendError(error: error ?? "")
        }
    }
    
    func load(){
        initViewSetup()
        delegate?.setLoading(true)
        fetchDataFromNetwork(page:pagination.pageNum, albumId: albumId, action: { [weak self] photos in
            guard let self = self else{ return }
            self.delegate?.setLoading(false)
            self.updatePhotoDto(photos: photos)
        })
        return
    }
    
    func initViewSetup() {
        delegate?.setUpTitle()
        delegate?.setUpNavTitleColor()
        delegate?.setUpRefresh()
    }
    
    func updatePhotoDto(photos: [PhotoModel]){
        photoList.append(contentsOf: mapPhotoDataToDto(data: photos))
    }
    
    func mapPhotoDataToDto(data:[PhotoModel]) -> [PhotoDto]{
        return data.map{ photo in
            PhotoDto(id: photo.id.toInt, title: photo.title.toString, imageUrl: photo.thumbnailUrl.toString)
        }
    }
    
    func onScrollToTheEnd() {
        pagination.incrementPageNumber()
        fetchDataFromNetwork(page: pagination.pageNum, albumId: albumId) { [weak self] photos in
            guard let self = self else{ return }
            self.updatePhotoDto(photos: photos)
            self.pagination.stopFetching(photos)
        }
    }
    
    func getPhotoItem(item: PhotoDto) {
        coordinatorDelegate?.showPhotoDetail(item: item)
    }
    
    func refresh() {
        pagination.resetPageNumber()
        fetchDataFromNetwork(page: pagination.pageNum, albumId: albumId) { [weak self] photos in
            guard let self = self else{ return }
            self.delegate?.doneRefreshing()
            self.updatePhotoDto(photos: photos)
        }
    }
    
    private func fetchDataFromNetwork(page:Int, albumId:Int, action:@escaping (([PhotoModel]) -> Void)){
        repository.fetchPhotoData(page: page, albumId: albumId).subscribe(onNext: { [weak self] data, err in
            guard let self = self else{ return }
            DispatchQueue.main.async {
                if let photos = data{
                    action(photos)
                }
                
                if let error = err{
                    self.error = error
                }
            }
        }).disposed(by: disposeBag)
    }
}
