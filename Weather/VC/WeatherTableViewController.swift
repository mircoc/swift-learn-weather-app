//
//  WeatherTableViewController.swift
//  Weather
//
//  Created by Mirco on 16/03/2019.
//  Copyright © 2019 Mirco. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {

    var cellViewModels = [WeatherCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weatherAPIClient = WeatherAPIClient()
        let weatherEndpoint = WeatherEndpoint.fivedayForecast(cityName: "Florence", countryCode: "IT")
        weatherAPIClient.weather(with: weatherEndpoint) { (either) in
            switch either {
            case .value(let forecast):
                print(forecast)
                
                self.cellViewModels = forecast.list.map {
                    WeatherCellViewModel(forecastItem: $0)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellViewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)

        // Configure the cell...
        let cellViewModel = cellViewModels[indexPath.row]
        cell.textLabel?.text = cellViewModel.text
        cell.detailTextLabel?.text = cellViewModel.details
        cellViewModel.loadImage { (image) in
            cell.imageView?.image = image
        }
        return cell
    }

}
