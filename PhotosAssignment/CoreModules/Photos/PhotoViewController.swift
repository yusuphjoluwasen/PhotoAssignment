//
//  PhotoViewController.swift
//  PhotosAssignment
//
//  Created by Guru on 01/06/2022.
//

import UIKit

final class PhotoViewController: UIViewController {
    var viewModel: PhotoViewModelProtocol?
    var contentView = PhotoView()
    var collectionClass = CompositionalCollectionView<PhotoDto,PhotoCell>()
    var cellData:[PhotoDto] = []{
        didSet{
            collectionClass.passDataToCollection(data: cellData)
        }
    }
    var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSetup()
        viewModel?.load()
    }
    
    override func loadView() {
        view = contentView
    }
    
    func initSetup(){
        setUpCollectionView()
        viewModel?.delegate = self
    }
    
    private func setUpCollectionView(){
        collectionClass.collectionview = contentView.collectionView
        contentView.collectionView.delegate = self
    }
}
