//
//  PhotoCell.swift
//  PhotosAssignment
//
//  Created by Guru on 02/06/2022.
//

import UIKit

final class PhotoCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let this = UILabel()
        this.setUpGenLabel(text: "", textColor: .photoTextColor, font: .systemFont14Bold,
                           numberOfLines: Constants.Dim.three)
        return this
    }()
    
    let imageView: UIImageView = {
        let this = UIImageView()
        this.setUpImageView(image: Constants.Other.placeholder, contentMode: .scaleToFill, cornerRadius: CGFloat(Constants.Dim.five))
        return this
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(Constants.Dim.hundred))
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: CGFloat(Constants.Dim.ten)),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}

extension PhotoCell:CollectionViewCellConfigurable {}
