//
//  NetworkApiTest.swift
//  PhotosAssignmentTests
//
//  Created by Guru on 04/06/2022.
//

import XCTest
@testable import PhotosAssignment

class NetworkApiTest: XCTestCase {
    
    var api:EndpointType!
    var request:URLRequest!
    
    override func setUp() {
        super.setUp()
        api = AlbumApi.album(params: ["_page" : "\(1)"])
        request = RequestFactory.request(endpoint: api)
    }
    
    func testApiUrlSetUp(){
        XCTAssertEqual(api.params, ["_page":"1"])
        XCTAssertEqual(api.baseURL, "http://testapi.pinch.nl:3000/")
        XCTAssertEqual(api.path, "albums")
        XCTAssertEqual(api.constructedURL, "http://testapi.pinch.nl:3000/albums")
    }

    func testRequestFactory(){
        XCTAssertTrue(request.url?.absoluteString == "http://testapi.pinch.nl:3000/albums?_page=1", "correct url")
    }
}
