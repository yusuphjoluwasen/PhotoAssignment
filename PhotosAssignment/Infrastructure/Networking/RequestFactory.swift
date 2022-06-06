//
//  RequestFactory.swift
//  PhotosAssignment
//
//  Created by Guru on 04/06/2022.
//
import Foundation

final class RequestFactory {
    static func request(endpoint: EndpointType) -> URLRequest {
        let urlString = endpoint.constructedURL
        let params = endpoint.params
        var components = URLComponents(string: urlString)
        if let params = params {
            components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value) }
        }
        let request = URLRequest(url: (components?.url)!)
        return request
    }
}
