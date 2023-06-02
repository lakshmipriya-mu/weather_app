//
//  WeatherSearchViewModel.swift
//  Weather App
//
//  Created by Lakshmi Priya on 6/1/23.
//

import Foundation

class SearchViewModel {
    var locations: [GeoCodeMapingModel] = []
    let dataManager: WeatherDataManaging
    let callback: (_ lat: Double, _ lon: Double) -> Void
    init(dataManager: WeatherDataManaging, callback: @escaping (Double, Double) -> Void) {
        self.dataManager = dataManager
        self.callback = callback
    }
    
    func getLocations(for location: String, callBack:@escaping ((Bool, WeatherError?) -> Void)) {
        dataManager.geoCodeApi(location: location) { [weak self] (response, error) in
           
            guard let data = response else {
                callBack(false, error)
                return
            }
            self?.locations = data
            callBack(true, nil)
        }
    }
    
    var numberOfRows: Int {
        locations.count
    }
    
    func item(for index: Int) -> GeoCodeMapingModel {
        locations[index]
    }
}
