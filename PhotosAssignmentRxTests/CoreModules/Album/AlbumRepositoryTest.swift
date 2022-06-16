//
//  MockRepositoryTest.swift
//  PhotosAssignmentTests
//
//  Created by Guru on 16/06/2022.
//
//check code coverage
import XCTest
import RxSwift

@testable import PhotosAssignment
class MockRepositoryTest: XCTestCase {
    
    var sut:MockAlbumRepository?
    let disposeBag = DisposeBag()
    var albumModelList:[AlbumModel]?
    
    override func setUp() {
        super.setUp()
        sut = MockAlbumRepository()
        albumModelList = createAlbumModelList()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_albums_completion_called() {
        let exp = expectation(description: "apiCall")
    
        var completionHandlerCalled = false
        fetchDataFromNetwork(page: 1) { album in
            completionHandlerCalled = true
            exp.fulfill()
        }
    
        wait(for: [exp], timeout: 1.0)
        XCTAssertTrue(completionHandlerCalled)
    }
    
    func test_fetch_albums_sucessful(){
        let exp = expectation(description: "fetchAlbums")
        var resp: [AlbumModel]? = nil
        
        fetchDataFromNetwork(page: 1) { album in
            resp = album
            exp.fulfill()
        }
    
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(resp?.count, 10)
    }
    
    func test_map_data_list_from_album_model_to_dto(){
        let data = sut?.mapAlbumDataToDto(data: createAlbumModelList())
        XCTAssertEqual(data?.first?.title, "omnis laborum odio")
    }

    private func fetchDataFromNetwork(page:Int, completion:@escaping (([AlbumModel]) -> Void)){
        sut?.fetchDataFromApi(page:page).subscribe(onNext: { data, _ in
                if let albums = data{
                    completion(albums)
                }
        }).disposed(by: disposeBag)
    }
    
    private func createAlbumModelList() -> [AlbumModel]{
        let album1 = AlbumModel(id: 3, userId: 1, title: "omnis laborum odio")
        let album2 = AlbumModel(id: 2, userId: 1, title: "sunt qui excepturi placeat culpa")
        return [album1, album2]
    }
}
