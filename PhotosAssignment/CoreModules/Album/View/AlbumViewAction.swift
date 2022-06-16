//
//  AlbumAction.swift
//  PhotosAssignment
//
//  Created by Guru on 04/06/2022.
//

import UIKit

extension AlbumViewController:AlbumViewControllerDelegate{
    func setUpTitle() {
        setUpNavigationTitle(viewModel?.getTitle)
    }
    
    func sendError(error: String) {
        simpleAlert(title: error)
    }
    
    func setLoading(_ isLoading: Bool) {
        switch isLoading {
        case true:
            NetworkLoader.shared.show()
        case false:
            NetworkLoader.shared.hide()
        }
    }
    
    func setUpRefresh() {
        let title = viewModel?.refreshTitle
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string:title.toString)
        refreshControl?.addTarget(self, action: #selector(refreshing), for: .valueChanged)
        tableView.addSubview(refreshControl!)
    }
    
    func reloadCollection(){
        reloaDataSource()
    }
    
    @objc
    func refreshing() {
        viewModel?.refresh()
    }
    
    func doneRefreshing() {
        refreshControl?.endRefreshing()
    }
    
    func onFetchingMoreData() {
        TableLoader.shared.show()
    }
    
    func doneFetchingMoreData() {
        TableLoader.shared.hide()
    }
}
