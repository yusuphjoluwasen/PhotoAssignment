//
//  RepositoryFactory.swift
//  PhotosAssignment
//
//  Created by Guru on 02/06/2022.
//
import Foundation
import RxSwift

protocol RepositoryFactoryDelegate{
    func fetchData<T:Codable>(request:EndpointType?) -> Observable<([T]?, String?)>
}

final class RepositoryFactory:RepositoryFactoryDelegate{
    let network:NetworkingDelegate
    
    init(network:NetworkingDelegate) {
        self.network = network
    }
    
     func fetchData<T:Codable>(request:EndpointType?) -> Observable<([T]?, String?)> {
        
        return Observable.create{ observer in
            
            let requestObserver = self.network.makeUrlRequest(request: request!, returnType: T.self).subscribe(onNext: { result in
                
                switch result{
                case .failure(let error):
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
