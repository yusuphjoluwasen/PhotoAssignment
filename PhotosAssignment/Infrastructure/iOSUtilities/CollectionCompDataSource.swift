//
//  ColectionCompDataSource.swift
//  Evaluation
//
//  Created by Guru on 28/05/2022.
//

import UIKit

public protocol CollectionViewCellConfigurable{
    associatedtype ItemType
    associatedtype CellType: UICollectionViewCell
    static func configureCellAtIndexPath(indexPath: IndexPath, item: ItemType, cell: CellType)
}

public class CompositionalCollectionView<Element:Hashable, Cell: CollectionViewCellConfigurable> where Cell.ItemType == Element{
    typealias CellRegistration = UICollectionView.CellRegistration<Cell.CellType, Element>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Element>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Element>
    public var collectionview:UICollectionView?
    
    public init() {}
    
    let cellRegistration = CellRegistration { cell, indexPath, item in
        Cell.configureCellAtIndexPath(indexPath: indexPath, item: item, cell: cell)
    }
    
    lazy var dataSource : DataSource = {
        let dataSource = DataSource(collectionView: collectionview!) { [weak self] collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: self!.cellRegistration, for: indexPath, item: item)
        }
        return dataSource
    }()
    
     enum Section {
        case sectionone
    }
    
    private func setUpDataSource(data:[Element]){
        var snapshot = Snapshot()
        snapshot.appendSections([Section.sectionone])
        snapshot.appendItems(data)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: Functions to be exposed
    func passDataToCollection(data:[Element]){
        setUpDataSource(data: data)
    }
    
    func getDataDource() -> DataSource{
        return dataSource
    }
}
    

