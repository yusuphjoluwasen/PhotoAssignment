//
//  NetworkingUtil.swift
//  Evaluation
//
//  Created by Guru on 28/05/2022.
//
import Foundation

// MARK: Request
protocol EndpointType {
    var baseURL: String { get }
    var path: String { get }
    var constructedURL: String { get }
    var params:[String:String]? { get }
}

// MARK: Error
enum RequestError: Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
}

extension RequestError{
    public var errorDescription: String {
        switch self {
        case .clientError:
            return NetworkConstants.clienterror
        case .serverError:
            return NetworkConstants.noservice
        case .noData:
            return NetworkConstants.clienterror
        case .dataDecodingError:
            return NetworkConstants.clienterror
        }
    }
}

// MARK: Response
public struct Response {
    fileprivate var data: Data
    public init(data: Data) {
        self.data = data
    }
}

extension Response {
    public func decode<T: Codable>(_ type: T.Type) -> [T]? {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode([T].self, from: data)
            return response
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: Constants
enum NetworkConstants{
    static let clienterror = "please check inputs"
    static let noservice = "service not available"
}


