//
//  WeatherAPIClient.swift
//  Weather
//
//  Created by Mirco on 17/03/2019.
//  Copyright © 2019 Mirco. All rights reserved.
//

import Foundation

class WeatherAPIClient : APIClient {
    var session : URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func weather(with endpoint: WeatherEndpoint, completion: @escaping (Either<Weather, APIError>) -> Void) {
        
        let request = endpoint.request
        self.fetch(with: request) { (either: Either<Weather, APIError>) in
            switch either {
            case .value(let weather):
                completion(.value(weather))
            case .error(let error):
                completion(.error(error))
            }
        }
        
    }
}
