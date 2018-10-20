//
//  Webservice.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 20/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)

    init(_ value: T) {
        self = Result.success(value)
    }

    init(_ value: E) {
        self = Result.failure(value)
    }

}

enum NetworkError: Error {
    case invalidData
    case emptyData
    case clientError(String)
    case redirection
    case serverError
    case networkError(String)
    case unknowm
}

final class Webservice: NSObject {

    let urlSession: URLSession

    init(urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.urlSession = urlSession
    }

    func load<T>(_ resource: Resource<T>,
                 decoder: JSONDecoder = JSONDecoder(),
                 completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask {

        let request = URLRequest(resource: resource)

        let task = urlSession.dataTask(with: request) { [unowned self] data, urlResponse, error in
            let result: Result<T, NetworkError>
            if let response = urlResponse as? HTTPURLResponse,
                let status = response.status,
                let data = data {
                switch status.responseType {
                case .success:
                    result = self.parse(data, for: resource, error: error)
                case .redirection:
                    result = Result(.redirection)
                case .clientError:
                    let message = "[\(response.statusCode)]: \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))"
                    result = Result(NetworkError.clientError(message))
                case .serverError:
                    result = Result(.serverError)
                default:
                    result = Result(.unknowm)
                }
            }
            else if let error = error {
                result = Result(.networkError(error.localizedDescription))
            }
            else {
                result = Result(.unknowm)
            }
            completion(result)
        }
        task.resume()
        return task
    }

    private func parse<T>(_ data: Data?,
                          for resource: Resource<T>,
                          error: Error?) -> Result<T, NetworkError> where T: Decodable {
        let result: Result<T, NetworkError>
        if let data = data {
            do {
                result = try Result(resource.parse(data))
            }
            catch {
                result = Result(NetworkError.invalidData)
            }
        }
        else if let error = error {
            fatalError("FIXME")
        }
        else {
            result = Result(NetworkError.emptyData)
        }
        return result
    }
}
