//
//  MockHttpClient.swift
//  EvaluationTests
//
//  Created by Guru on 29/05/2022.
//

import Foundation
import RxSwift
@testable import PhotosAssignment

class MockAlbumHttpClient:NetworkingDelegate{
    func makeUrlRequest<T:Codable>(request: EndpointType?, returnType: T.Type) -> Observable<Handler<T>>{
        let stubGen = StubGenerator()
        let data = stubGen.stubResponse(resource: .albums, returnType: returnType)
        
        return Observable.create{ observer in
            guard let data = data else {
                observer.onNext(.failure(.noData))
                fatalError("no data")
            }
            
            let newData = Response(data: data)
            guard let decoded = newData.decode(returnType) else {
                observer.onNext(.failure(.dataDecodingError))
                fatalError("decoding error")
            }
            observer.onNext(.success(decoded))
            return Disposables.create {
                
            }
        }
    }
}


