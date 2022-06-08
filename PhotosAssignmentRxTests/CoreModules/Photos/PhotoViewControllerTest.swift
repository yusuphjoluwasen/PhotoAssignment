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
    var photo_list:[PhotoDto]?
    var cell:PhotoCell?
    
    override func setUp() {
        super.setUp()

        sut = PhotoViewController()
        photo_list = getPhotos()
    }
    
    override func tearDown() {
        sut = nil
        cell = nil
        photo_list = nil
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
        XCTAssertEqual(first_photo?.title, "reprehenderit est deserunt velit ipsam")
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
        addDataToController()
        sut?.initSetup()
        
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
        //when
        sut?.initSetup()
        
        sut?.cellData = photo_list ?? []
    }
    
    func setUpCell(){
        let indexPath = IndexPath(row: 0, section: 0)
        sut?.contentView.collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell")
        cell = sut?.contentView.collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell
    }
    
    private func getPhotos() -> [PhotoDto]{
        let photo1 = PhotoDto(id: 1, title: "reprehenderit est deserunt velit ipsam", imageUrl: "https://via.placeholder.com/150/92c952")
        let photo2 = PhotoDto(id: 1, title: "officia porro iure quia iusto qui ipsa ut modi", imageUrl: "https://via.placeholder.com/150/771796")
        return [photo1, photo2]
    }
    
    
}
