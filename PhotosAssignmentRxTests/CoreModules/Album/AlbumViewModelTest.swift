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

class AlbumViewModelTest: XCTestCase {

    var repository:MockAlbumRepository?
    let disposeBag = DisposeBag()
    var sut:AlbumViewModel?
    var data:[AlbumDto]?

    override func setUp() {
        super.setUp()
        repository = MockAlbumRepository()
        sut = AlbumViewModel(repository: repository!)
        data =  getAlbumDtoList()
    }

    override func tearDown() {
        sut = nil
        repository = nil
        data = nil
        super.tearDown()
    }
    
    func test_album_list_is_empty(){
        XCTAssertTrue(sut?.albumList.count == 0, "list is empty")
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
        XCTAssertEqual(sut?.pagination.pageNum, 1)
    }
    
    func test_page_number_increment(){
        sut?.pagination.incrementPageNumber()
        XCTAssertEqual(sut?.pagination.pageNum, 2)
    }
    
    func test_data_source(){
        let tableView = UITableView()
        sut?.albumList = data!
        let datasource = sut?.getDataSource(tableView)
        XCTAssertEqual(datasource?.albums.count, 1)
    }
    
    func test_load(){
        let exp = expectation(description: "load")
        
        repository?.provideData(loading: {
            
        }, completion: { [weak self] album, error in
            self?.sut?.albumList = album ?? []
        })
        XCTAssertEqual(sut?.albumList.count, 10)
        
        exp.fulfill()
        
        sut?.load()
        wait(for: [exp], timeout: 0.2)
    }
    
    private func getAlbumDtoList() -> [AlbumDto]{
        return [AlbumDto(id: 1, title: "sunt qui excepturi placeat culpa")]
    }
}
