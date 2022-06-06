//
//  PhotoView.swift
//  PhotosAssignment
//
//  Created by Guru on 01/06/2022.
//

import Foundation
import UIKit

final class PhotoView: UIView {
     lazy var collectionView: UICollectionView = {
         let layout = buildLayout(items: LayoutItems(itemWidth: .fractionalWidth(0.5), itemHeight: .absolute(190), groupHeight: .absolute(190), horizontalSpaceBtwItems: CGFloat.margin4x, verticalSpaceBtwItem: CGFloat.margin4x,numberOfItemsInGroup:2))
        let this = UICollectionView(frame: .zero, collectionViewLayout: layout)
        this.setUpCollectionView()
        return this
    }()
    
    convenience init() {
        self.init(frame: .zero)
        configureViews()
        configureSubviews()
        configureConstraints()
    }
    
    private func configureViews(){
        backgroundColor = .white
    }
    
    private func configureSubviews() {
        addSubview(collectionView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: CGFloat.size20),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CGFloat.size20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.size20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CGFloat.size20)
        ])
    }
}
