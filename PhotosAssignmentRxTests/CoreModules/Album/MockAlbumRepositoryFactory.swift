//
//  RepositoryTest.swift
//  EvaluationTests
//
//  Created by Guru on 29/05/2022.
//

@testable import PhotosAssignment
import RxSwift

final class MockAlbumRepositoryFactory:RepositoryFactoryDelegate{
    func fetchData<T>(request: EndpointType?) -> Observable<([T]?, String?)> where T : Decodable, T : Encodable {
        
        let client = MockAlbumHttpClient()
        
        return Observable.create{ observer in
            
            let requestObserver = client.makeUrlRequest(request: nil, returnType: T.self).subscribe(onNext: { result in
                
                switch result{
                case .failure(let error):
                    print(error.errorDescription)
                    observer.onNext((nil, error.errorDescription))
                case .success(let data):
                    observer.onNext((data, nil))
                }
            })
            return Disposables.create {
                requestObserver.dispose()
            }
        }
    }
}
