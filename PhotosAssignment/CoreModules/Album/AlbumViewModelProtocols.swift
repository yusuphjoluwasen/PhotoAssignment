//
//  AlbumViewModelProtocols.swift
//  PhotosAssignment
//
//  Created by Guru on 04/06/2022.
//

import Foundation

protocol AlbumListViewModelProtocol:AnyObject {
    var coordinatorDelegate: PhotosCoordinatorDelegate? { get set }
    var delegate: AlbumViewControllerDelegate? { get set }
    var getTitle:String { get }
    var getCellIndentifier:String { get }
    var refreshTitle:String { get }
    
    func load()
    func initViewSetup()
    func getDataSource() -> AlbumDataSource
    func onScrollToTheEnd()
    func getAlbumItem(at index: Int)
    func refresh()
}

protocol AlbumViewControllerDelegate:AnyObject{
    func setUpTitle()
    func sendError(error:String)
    func setLoading(_ isLoading: Bool)
    func reloadCollection()
    func setUpRefresh()
    func refreshing()
    func doneRefreshing()
    func onFetchingMoreData()
    func doneFetchingMoreData()
}

struct AlbumDto:Hashable{
    let id:Int
    let title:String
}
