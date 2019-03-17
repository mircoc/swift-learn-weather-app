//
//  Endpoint.swift
//  Weather
//
//  Created by Mirco on 17/03/2019.
//  Copyright © 2019 Mirco. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseUrl : String { get }
    var path : String { get }
    var queryItems : [URLQueryItem] { get }
}

extension Endpoint {
    var urlComponent : URLComponents {
        var component = URLComponents(string: baseUrl)
        component?.path = path
        component?.queryItems = queryItems
        
        return component!
    }
    
    var request : URLRequest {
        return URLRequest(url: urlComponent.url!)
    }
}

enum WeatherEndpoint : Endpoint {
    case fivedayForecast(cityName: String, countryCode: String)
    var baseUrl: String {
        return "https://api.openweathermap.org"
    }
    
    var path: String {
        switch self {
        case .fivedayForecast:
            return "/data/2.5/forecast"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .fivedayForecast(let cityName, let countryCode):
            return [
                URLQueryItem(name: "q", value: "\(cityName),\(countryCode)"),
                URLQueryItem(name: "appid", value: "68e78416f49138f3b55487e4a2646881"),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "lang", value: "it"),
            ]
        }
    }
    
    
}
