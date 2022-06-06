//
//  MockAlbumViewModel.swift
//  PhotosAssignmentTests
//
//  Created by Guru on 04/06/2022.
//

import Foundation
import RxSwift
import XCTest
@testable import PhotosAssignment

class MockAlbumViewModelTest: XCTestCase {

    var repository:MockAlbumRepository?
    let disposeBag = DisposeBag()
    var sut:AlbumViewModel?
    var data:[AlbumModel]?

    override func setUp() {
        super.setUp()
        repository = MockAlbumRepository()
        sut = AlbumViewModel(repository: repository!)
        data =  fetchAlbums()
    }

    override func tearDown() {
        sut = nil
        repository = nil
        data = nil
        super.tearDown()
    }

    func test_album_fetch_sucessfully(){
        XCTAssertNotNil(fetchAlbums(), "albums are not empty")
    }
    
    func test_album_list_is_empty(){
        XCTAssertTrue(sut?.albumList.count == 0, "list is empty")
    }
    
    func test_album_list_is_not_empty(){
        sut?.updateAlbumDto(albums: data!)
        XCTAssertTrue(sut?.albumList.count == 10, "list is not empty")
    }
    
    func test_album_model_list_converted_to_album_list(){
        let newlist = sut?.mapAlbumDataToDto(data: data!)
        XCTAssertTrue(newlist?.count == 10, "converted sucessfully")
    }
    
    func test_album_database_is_not_empty(){
        let albumdblist = saveToDBandFetch()
        XCTAssertNotNil(albumdblist, "album database is not empty")
    }
    
    func  test_album_db_list_converted_to_album_dto_list(){
        let albumdblist = saveToDBandFetch()
        let datadto = sut?.mapAlbumDataToDto(data: albumdblist!)
        XCTAssertNotNil(datadto, "converted sucessfully")
    }

    func test_nav_title_is_correct(){
        XCTAssertEqual(sut?.getTitle, "Album List")
    }
    
    func test_cell_title_is_correct(){
        XCTAssertEqual(sut?.getCellIndentifier, "albumcell")
    }
    
    func test_refresh_title_is_correct(){
        XCTAssertEqual(sut?.refreshTitle, "Pull to refresh")
    }
    
    func test_page_number_is_one(){
        XCTAssertEqual(sut?.pageNumber, 1)
    }
    
    func test_page_number_increment(){
        sut?.incrementPageNumber()
        XCTAssertEqual(sut?.pageNumber, 2)
    }
    
    func test_data_source(){
        sut?.updateAlbumDto(albums: data!)
        let datasource = sut?.getDataSource()
        XCTAssertEqual(datasource?.albums.count, 10)
    }
    
    func test_refresh(){
        let exp = expectation(description: "refresh")
        
        sut?.refresh()
        
        exp.fulfill()
        
        wait(for: [exp], timeout: 1.0)
    
        XCTAssertEqual(sut?.pageNumber, 1)
    }
    
    func test_on_scroll_to_the_end(){
        let exp = expectation(description: "scroll to the end")
       
        sut?.onScrollToTheEnd()
        
        exp.fulfill()
        
        wait(for: [exp], timeout: 1.0)
    
        XCTAssertEqual(sut?.pageNumber, 2)
    }
    
    func test_albums_completion_called() {
        let exp = expectation(description: "apiCall")
        
        var completionHandlerCalled = false
        fetchDataFromNetwork(page: 1) { album in
            completionHandlerCalled = true
            print(album)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertTrue(completionHandlerCalled)
    }
    
    private func saveToDBandFetch() -> [Album]?{
        sut?.saveToDB(albums: data!)
        return sut?.fetchDataFromDB()
    }
    
    private func fetchAlbums() -> [AlbumModel]?{
        var resp: [AlbumModel]? = nil
        fetchDataFromNetwork(page: 1) { albums in
           resp = albums
        }
        return resp
    }
    
    private func fetchDataFromNetwork(page:Int, completion:@escaping (([AlbumModel]) -> Void)){
        repository?.fetchAlbumData(page:page).subscribe(onNext: { data, _ in
                if let albums = data{
                    completion(albums)
                }
        }).disposed(by: disposeBag)
    }
}