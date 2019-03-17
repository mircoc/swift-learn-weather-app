//
//  WeatherCellViewModel.swift
//  Weather
//
//  Created by Mirco on 17/03/2019.
//  Copyright © 2019 Mirco. All rights reserved.
//

import UIKit

struct WeatherCellViewModel {
    let dt : Int
    let dtTxt : String
    let temp : Float
    let humidity : Int
    let pressure : Float
    let firstDataDescShort : String
    let firstDataDescLong : String
    let iconCode : String
    
    let text : String
    let details : String
    
    init(forecastItem: ForecastItem? = nil) {
        self.dt = (forecastItem?.dt)!
        self.dtTxt = (forecastItem?.dtTxt)!
        self.temp = (forecastItem?.main.temp)!
        self.humidity = (forecastItem?.main.humidity)!
        self.pressure = (forecastItem?.main.pressure)!
        self.firstDataDescShort = (forecastItem?.weather.first!.main)!
        self.firstDataDescLong = (forecastItem?.weather.first!.description)!
        self.iconCode = (forecastItem?.weather.first!.icon)!
        
        self.text = self.dtTxt
        self.details = "T.\(self.temp)°C H.\(self.humidity)% \(self.firstDataDescLong)"
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        // FIXME: get images from device
        let imageIcon = URL(string: "https://openweathermap.org/img/w/\(iconCode).png")
        guard let imageData = try? Data(contentsOf: imageIcon!) else {
            return
        }
        
        let image = UIImage(data: imageData)
        
        DispatchQueue.main.async {
            completion(image)
        }
    }
}
