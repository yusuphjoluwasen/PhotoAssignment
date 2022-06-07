//
//  AlbumViewController.swift
//  PhotosAssignment
//
//  Created by Guru on 01/06/2022.
//

import UIKit

class AlbumViewController:UIViewController{
    var viewModel: AlbumListViewModelProtocol?
    private(set) var dataSource: AlbumDataSource?
    
    
    @IBOutlet var tableView:UITableView!
     var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        viewModel?.load()
    }
    
    public func reloaDataSource() {
        dataSource = viewModel?.getDataSource(tableView)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView?.tableFooterView = TableLoader.shared.spinnerFooter(tableView)
        tableView.reloadData()
    }
}



