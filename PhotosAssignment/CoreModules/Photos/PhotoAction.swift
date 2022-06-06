//
//  PhotoAction.swift
//  PhotosAssignment
//
//  Created by Guru on 05/06/2022.
//

import UIKit

extension PhotoViewController:PhotoViewControllerDelegate{
    func setUpTitle() {
        self.navigationItem.title = viewModel?.getTitle
    }
    
    func setUpNavTitleColor() {
        let color = viewModel?.navTitleColor
        navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: color!]
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
    
    func reloadCollection() {
        cellData = viewModel?.photoList ?? []
    }
    
    func setUpRefresh() {
        let title = viewModel?.refreshTitle
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string:title.toString)
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        contentView.collectionView.addSubview(refreshControl!)
    }
    
    @objc
    func refresh() {
        viewModel?.refresh()
    }
    
    func doneRefreshing() {
        refreshControl?.endRefreshing()
    }
}

extension PhotoViewController:UICollectionViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.atBottom(contentView.collectionView){
            viewModel?.onScrollToTheEnd()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = collectionClass.getDataDource().itemIdentifier(for: indexPath) else { return }
        viewModel?.getPhotoItem(item: item)
    }
}


