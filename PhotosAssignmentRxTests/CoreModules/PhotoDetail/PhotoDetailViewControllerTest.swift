//
//  PhotoDetailViewControllerTest.swift
//  PhotosAssignmentTests
//
//  Created by Guru on 05/06/2022.
//

import Foundation
import XCTest
@testable import PhotosAssignment

class PhotoDetailControllerTest: XCTestCase {

    var sut:PhotoDetailsViewController?
    var viewmodel:PhotoDetailsViewModel?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        viewmodel = nil
        sut = nil
        super.tearDown()
    }
    
    func test_view_controller_is_nil(){
        XCTAssertNil(sut)
    }
    
    func test_view_controller_items_are_nil(){
        XCTAssertNil(sut?.titleLabel.text)
        XCTAssertNil(sut?.imageView.image)
    }
    
    func test_view_controller_initialize_successfully(){
        makeSUT()
        loadView()
        XCTAssertNotNil(sut?.titleLabel.text)
        XCTAssertNotNil(sut?.imageView.image)
    }
    
    func test_display_correct_navigation_text(){
        makeSUT()
        initializeSutViewModel()
        loadView()
        sut?.initSetup()
        viewmodel?.delegate?.setUpTitle()
        XCTAssertEqual(sut?.navigationItem.title,"Photo Detail")
    }
    
    func test_title_label_display_default_text(){
        makeSUT()
        loadView()
        XCTAssertEqual(sut?.titleLabel.text,"Label", "title has not been set")
    }
    
    func test_title_label_display_text_from_viewmodel(){
        makeSUT()
        initializeSutViewModel()
        loadView()
        XCTAssertEqual(sut?.titleLabel.text,"accusamus beatae ad facilis cum similique qui sunt")
    }
    
    func test_image_view_is_not_empty_after_load(){
        makeSUT()
        initializeSutViewModel()
        loadView()
        let image = UIImage(named: "thumbnail")
        XCTAssertNotNil(sut?.imageView.image)
        XCTAssertEqual(sut?.imageView.image, image, "image displayed correctly")
    }
    
    //Refactor
    func makeSUT(){
        sut = StoryboardInitializable.initFromStoryboard(storyboardIdentifier: Constants.StoryboardIdentifiers.photodetail) as? PhotoDetailsViewController
    }
    
    func initializeSutViewModel(){
        viewmodel = PhotoDetailsViewModel(title: "accusamus beatae ad facilis cum similique qui sunt", image: "thumbnail")
        sut?.viewModel = viewmodel
    }
    
    func loadView(){
        sut?.loadViewIfNeeded()
    }
}
