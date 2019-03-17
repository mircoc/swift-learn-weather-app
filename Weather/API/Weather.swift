//
//  Weather.swift
//  Weather
//
//  Created by Mirco on 16/03/2019.
//  Copyright © 2019 Mirco. All rights reserved.
//

import Foundation

class Weather : Codable {
    let list : [ForecastItem]
}

/*
 
 {
     dt: 1552780800,
     main: {
         temp: 280,
         temp_min: 279.413,
         temp_max: 280,
         pressure: 1026.2,
         sea_level: 1026.2,
         grnd_level: 983.42,
         humidity: 35,
         temp_kf: 0.59
     },
     weather: [
         {
             id: 800,
             main: "Clear",
             description: "clear sky",
             icon: "01n"
         }
     ],
     clouds: {
        all: 0
     },
     wind: {
         speed: 2.26,
         deg: 317.001
     },
     sys: {
        pod: "n"
     },
     dt_txt: "2019-03-17 00:00:00"
 }
 */
 
struct ForecastItem : Codable {
    let dt : Int
    let dtTxt : String
    let main : MainData
    let weather : [WeatherData]
    let wind : WindData

    private enum CodingKeys: String, CodingKey {
        case dtTxt = "dt_txt"
        case dt
        case main
        case weather
        case wind
    }
}

struct MainData : Codable {
    let temp : Float
    let humidity : Int
    let pressure : Float
}

struct WeatherData : Codable {
    let main : String
    let description : String
    let icon : String
}

struct WindData : Codable {
    let speed : Float
    let deg : Float
}
