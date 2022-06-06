//
//  PhotoDetailsViewModel.swift
//  PhotosAssignment
//
//  Created by Guru on 05/06/2022.
//
import Foundation

protocol PhotoDetailsViewModelProtocol:AnyObject {
    var delegate: PhotoDetailsViewControllerDelegate? { get set }
    var getTitle:String { get }
    var title:String { get }
    var image:String { get }
    func load()
}

protocol PhotoDetailsViewControllerDelegate:AnyObject{
    func setUpTitle()
    func setUpViews()
}

final class PhotoDetailsViewModel:PhotoDetailsViewModelProtocol{
    weak var delegate: PhotoDetailsViewControllerDelegate?
    var getTitle: String { Constants.Nav.photodetail }
    let title:String
    var image:String
    
    init(title:String,image:String) {
        self.title = title
        self.image = image
    }
    
    func load() {
        delegate?.setUpTitle()
        delegate?.setUpViews()
    }
}
