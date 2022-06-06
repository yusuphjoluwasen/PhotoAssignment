//
//  AlbumDataSource.swift
//  PhotosAssignment
//
//  Created by Guru on 04/06/2022.
//

import UIKit

final class AlbumDataSource:NSObject{
    typealias AlbumDidSelectItemHandler = (Int) -> Void
    typealias ScrollToTheEndHandler = () -> Void
    
    var albums:[AlbumDto] = []
    var cellIndentifier:String = Constants.Cell.album
    
    init(albums:[AlbumDto]) {
        self.albums = albums
    }
}

extension AlbumDataSource:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.Dim.one
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  cellIndentifier, for: indexPath)
        let album = albums[indexPath.item]
        cell.textLabel?.text = album.title
        cell.textLabel?.numberOfLines = Constants.Dim.two
        return cell
    }
}

extension AlbumViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.getAlbumItem(at: indexPath.item)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.atBottom(tableView){
            viewModel?.onScrollToTheEnd()
        }
    }
}
