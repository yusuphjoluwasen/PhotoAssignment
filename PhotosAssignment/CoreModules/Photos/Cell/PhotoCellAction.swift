//
//  PhotoCellAction.swift
//  PhotosAssignment
//
//  Created by Guru on 02/06/2022.
//

import Foundation
import UIKit

extension PhotoCell {
    func setUpActions(){
        configureView()
        configureSubviews()
        configureConstraints()
    }
    
    private func configureView(){
        backgroundColor = .black
        layer.cornerRadius = CGFloat(Constants.Dim.five)
        titleLabel.textAlignment = .center
    }
    
    private func configureSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
        
    }
    
    static func configureCellAtIndexPath(indexPath: IndexPath, item: PhotoDto, cell:PhotoCell) {
        cell.populate(item)
    }

    func populate(_ data: PhotoDto) {
        titleLabel.text = data.title
        imageView.loadImageUsingKingFisher(urlString: data.imageUrl, placeholder: Constants.Other.placeholder, cornerRadius: CGFloat(Constants.Dim.five))
    }
}
