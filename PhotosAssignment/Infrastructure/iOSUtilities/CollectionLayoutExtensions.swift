//
//  CollectionLayoutExtensions.swift
//  Evaluation
//
//  Created by Guru on 28/05/2022.
//

import UIKit

private func setUpCollectionViewLayout(l:LayoutItems) -> UICollectionViewCompositionalLayout{
    //Item
    let itemSize = NSCollectionLayoutSize(widthDimension: l.itemWidth, heightDimension: l.itemHeight)
    let itemInset:NSDirectionalEdgeInsets = .init(top: 0, leading: 0, bottom: l.verticalSpaceBtwItem, trailing: 0)
    let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
    itemLayout.contentInsets = itemInset
    
    // Group
    let groupSize = NSCollectionLayoutSize(widthDimension: l.groupWidth, heightDimension: l.groupHeight)
    let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,subitem: itemLayout,count: l.numberOfItemsInGroup)
    groupLayout.interItemSpacing = .fixed(l.horizontalSpaceBtwItems)
    
    // Section
    let section = NSCollectionLayoutSection(group: groupLayout)
    return UICollectionViewCompositionalLayout(section: section)
}

//MARK:- Functions to be exposed
public func buildLayout(items:LayoutItems) -> UICollectionViewCompositionalLayout{
    return setUpCollectionViewLayout(l: items)
}

public struct LayoutItems{
    var itemWidth:NSCollectionLayoutDimension
    var itemHeight:NSCollectionLayoutDimension
    var groupWidth:NSCollectionLayoutDimension = .fractionalWidth(1)
    var groupHeight:NSCollectionLayoutDimension
    var horizontalSpaceBtwItems:CGFloat
    var verticalSpaceBtwItem:CGFloat
    var numberOfItemsInGroup:Int = 1
}

