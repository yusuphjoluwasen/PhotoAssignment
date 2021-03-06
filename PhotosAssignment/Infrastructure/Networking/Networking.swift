//
//  Networking.swift
//  Evaluation
//
//  Created by Guru on 28/05/2022.
//
import Foundation
import RxSwift

typealias Handler<T:Codable> = (Result<[T], RequestError>)

protocol NetworkingDelegate{
    func makeUrlRequest<T:Codable>(request: EndpointType?, returnType: T.Type) -> Observable<Handler<T>>
}

struct Networking:NetworkingDelegate {
    func makeUrlRequest<T:Codable>(request: EndpointType?, returnType: T.Type) -> Observable<Handler<T>> {
        
        return Observable.create{ observer in
            guard let request = request else {
                return Disposables.create { observer.onNext(.failure(.invalidUrl)) }
            }
            let urlRequest = RequestFactory.request(endpoint: request)
            
            let urlTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let _ = error?.isConnectivityError {
                    observer.onNext(.failure(.connectivityError))
                    return
                }
                
                guard error == nil else {
                    observer.onNext(.failure(.clientError))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    observer.onNext(.failure(.serverError))
                    return
                }
                
                guard let data = data else {
                    observer.onNext(.failure(.noData))
                    return
                }
                
                let newData = Response(data: data)
                guard let decoded = newData.decode(returnType) else {
                    observer.onNext(.failure(.dataDecodingError))
                    return
                }
                
                observer.onNext(.success(decoded))
            }
            
            urlTask.resume()
            return Disposables.create {
                urlTask.cancel()
            }
        }
    }
}



