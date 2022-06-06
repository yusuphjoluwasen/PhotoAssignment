//
//  PhotoViewControllerTest.swift
//  PhotosAssignmentTests
//
//  Created by Guru on 05/06/2022.
//

import Foundation
import XCTest
import RxSwift
@testable import PhotosAssignment

class PhotoControllerTest: XCTestCase {

    var sut:PhotoViewController?
    var repo:MockPhotoRepository?
    var viewmodel:PhotoViewModel?
    var photo_list:[PhotoModel]?
    var photo_list_dto:[PhotoDto]?
    let disposeBag = DisposeBag()
    var cell:PhotoCell?
    
    override func setUp() {
        super.setUp()
        repo = MockPhotoRepository()
        viewmodel = PhotoViewModel(repository: repo!, albumId: 1)
        sut = PhotoViewController()
        sut?.viewModel = viewmodel
        photo_list = fetchPhotos()
    }
    
    override func tearDown() {
        repo = nil
        viewmodel = nil
        sut = nil
        cell = nil
        photo_list = nil
        photo_list_dto = nil
        super.tearDown()
    }
    
    func test_photo_data_is_empty_before_load(){
        XCTAssertTrue(sut?.cellData.count == 0, "view controller datasource should be empty")
    }
    
    func test_photo_data_is_not_empty_after_load(){
        addDataToController()
        
        //then
        XCTAssertTrue(sut?.cellData.count != 0, "view controller datasource should not be empty")
    }
    
    func test_photo_list_is_correct(){
        addDataToController()
        let first_photo = sut?.cellData[0]
        
        XCTAssertEqual(first_photo?.id, 1)
        XCTAssertEqual(first_photo?.title, "accusamus beatae ad facilis cum similique qui sunt")
        XCTAssertEqual(first_photo?.imageUrl, "https://via.placeholder.com/150/92c952")
    }
    
    func test_has_a_collectionview(){
        XCTAssertNotNil(sut?.contentView.collectionView)
    }

    func test_collection_view_has_no_delegate(){
        XCTAssertNil(sut?.contentView.collectionView.delegate)
    }

    func test_collection_view_has_a_delegate(){
        sut?.initSetup()
        XCTAssertNotNil(sut?.contentView.collectionView.delegate)
    }

    func test_collection_view_datasource_has_not_been_set(){
        XCTAssertNil(sut?.contentView.collectionView.dataSource)
    }
    
    func test_collection_view_has_a_datasource(){
        sut?.initSetup()
        viewmodel?.delegate?.reloadCollection()
        
        XCTAssertNotNil(sut?.contentView.collectionView.dataSource)
    }

    func test_collection_view_cell_display_correct_data(){
        setUpCell()
        let photoDTO = PhotoDto(id: 1, title: "title", imageUrl: "image")
        cell?.populate(photoDTO)
        XCTAssertTrue(cell?.titleLabel.text == "title", "display correct text")
    }
    
    //refactor
    func addDataToController(){
        //Given
        let photo_list_dto = viewmodel?.mapPhotoDataToDto(data: photo_list!)
        viewmodel?.photoList = photo_list_dto!
        
        //when
        sut?.initSetup()
        viewmodel?.delegate?.reloadCollection()
    }
    
    func setUpCell(){
        let indexPath = IndexPath(row: 0, section: 0)
        sut?.contentView.collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell")
        cell = sut?.contentView.collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell
    }
    
    private func fetchPhotos() -> [PhotoModel]?{
        var resp: [PhotoModel]? = nil
        fetchDataFromNetwork(page: 1) { photos in
           resp = photos
        }
        return resp
    }
    
    private func fetchDataFromNetwork(page:Int, completion:@escaping (([PhotoModel]) -> Void)){
        repo?.fetchPhotoData(page:page, albumId: 1).subscribe(onNext: { data, _ in
                if let photos = data{
                    completion(photos)
                }
        }).disposed(by: disposeBag)
    }
}
