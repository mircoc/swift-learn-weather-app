//
//  APIClient.swift
//  Weather
//
//  Created by Mirco on 16/03/2019.
//  Copyright © 2019 Mirco. All rights reserved.
//

import Foundation

enum Either<V, E: Error> {
    case value(V)
    case error(E)
}

enum APIError : Error {
    case apiError
    case badResponse
    case jsonDecoder
    case unknown(String)
}

protocol APIClient {
    var session : URLSession { get }
    func fetch<V: Codable>(with request: URLRequest, completion: @escaping (Either<V, APIError>) -> Void)
}

extension APIClient {
    func fetch<V: Codable>(with request: URLRequest, completion: @escaping (Either<V, APIError>) -> Void) {
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.error(.apiError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                completion(.error(.badResponse))
                return
            }
            
            do {
                let value = try JSONDecoder().decode(V.self, from: data!)
                completion(.value(value))
            }
            catch let error {
                print(error)
                completion(.error(.jsonDecoder))
                return
            }
        }
        
        task.resume()
    }

}
