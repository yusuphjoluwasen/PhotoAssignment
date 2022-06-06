//
//  PhotoDetailsViewController.swift
//  PhotosAssignment
//
//  Created by Guru on 05/06/2022.
//

import UIKit
import Kingfisher

final class PhotoDetailsViewController: UIViewController {
    var viewModel: PhotoDetailsViewModelProtocol?
    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var imageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetup()
        viewModel?.load()
    }
    
    func initSetup(){
        viewModel?.delegate = self
    }
}

extension PhotoDetailsViewController:PhotoDetailsViewControllerDelegate{
    func setUpTitle() {
        navigationItem.title = viewModel?.getTitle
    }
    
    func setUpViews(){
        titleLabel.text = viewModel?.title
        titleLabel.numberOfLines = Constants.Dim.two
        let image = viewModel?.image
        imageView.loadImageUsingKingFisher(urlString: image.toString, placeholder: Constants.Other.placeholder, cornerRadius: CGFloat(Constants.Dim.five))
    }
}
