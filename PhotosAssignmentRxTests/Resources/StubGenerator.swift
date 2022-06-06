//
//  StubGenerator.swift
//  EvaluationTests
//
//  Created by Guru on 29/05/2022.
//

import Foundation
@testable import PhotosAssignment

class StubGenerator {
    
    enum AlbumResource: String{
        case albums
        case photos
    }
    
    func stubResponse<T:Codable>(resource:AlbumResource, returnType: T.Type) -> Data? {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: resource.rawValue, ofType: "json") else {
            fatalError("json not found")
        }
        
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert json to String")
        }
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }
        return jsonData
    }
}
