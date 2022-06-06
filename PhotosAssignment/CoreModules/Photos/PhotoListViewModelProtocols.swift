//
//  PhotoListViewModelProtocols.swift
//  PhotosAssignment
//
//  Created by Guru on 04/06/2022.
//

import UIKit

protocol PhotoViewModelProtocol:AnyObject {
    var coordinatorDelegate: PhotosCoordinatorDetailDelegate? { get set }
    var delegate: PhotoViewControllerDelegate? { get set }
    var getTitle:String { get }
    var navTitleColor: UIColor { get }
    var refreshTitle:String { get }
    var photoList:[PhotoDto] { get set }
    
    func load()
    func initViewSetup()
    func onScrollToTheEnd()
    func getPhotoItem(item: PhotoDto)
    func refresh()
}

protocol PhotoViewControllerDelegate:AnyObject{
    func setUpTitle()
    func setUpNavTitleColor()
    func sendError(error:String)
    func setLoading(_ isLoading: Bool)
    func reloadCollection()
    func setUpRefresh()
    func refresh()
    func doneRefreshing()
}

struct PhotoDto:Hashable{
    let id:Int
    let title:String
    let imageUrl:String
}

