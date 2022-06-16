//
//  PhotoViewModel.swift
//  PhotosAssignment
//
//  Created by Guru on 01/06/2022.
//

import Foundation
import UIKit

class PhotoViewModel:PhotoViewModelProtocol{
    var coordinatorDelegate: PhotosCoordinatorDetailDelegate?
    weak var delegate: PhotoViewControllerDelegate?
    var getTitle: String { Constants.Nav.photos }
    var navTitleColor: UIColor { UIColor.photoTextColor }
    var refreshTitle: String { Constants.Other.refreshtitle }
    let pagination = PaginationApiClass<PhotoDto>()
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
        repository.fetch(page:pagination.pageNum, albumId: albumId, completion: { [weak self] photos, err in
            guard let self = self else{ return }
            self.updateUI(photos, err) { [weak self] in
                guard let self = self else{ return }
                self.delegate?.setLoading(false)
                self.updatePhotoDto(photos: photos ?? [])
            }
        })
        return
    }
    
    func initViewSetup() {
        delegate?.setUpTitle()
        delegate?.setUpNavTitleColor()
        delegate?.setUpRefresh()
    }
    
    func updatePhotoDto(photos: [PhotoDto]){
        photoList.append(contentsOf:photos)
    }
    
    
    func onScrollToTheEnd() {
        pagination.incrementPageNumber()
        repository.fetch(page: pagination.pageNum, albumId: albumId) { [weak self] photos, err in
            guard let self = self else{ return }
            self.updateUI(photos, err) { [weak self] in
                guard let self = self else{ return }
                self.updatePhotoDto(photos: photos ?? [])
                self.pagination.stopFetching(photos ?? [])
            }
        }
    }
    
    func getPhotoItem(item: PhotoDto) {
        coordinatorDelegate?.showPhotoDetail(item: item)
    }
    
    func refresh() {
        pagination.resetPageNumber()
        repository.fetch(page: pagination.pageNum, albumId: albumId) { [weak self] photos,err  in
            guard let self = self else{ return }
            self.updateUI(photos, err) { [weak self] in
                guard let self = self else{ return }
                self.delegate?.doneRefreshing()
                self.updatePhotoDto(photos: photos ?? [])
            }
        }
    }
    
    func updateUI(_ photos:[PhotoDto]?, _ error:String?, _ completion: @escaping () -> ()){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let error = error{
                self.error = error
            }
            if let _ = photos{
                completion()
            }
        }
    }
}
