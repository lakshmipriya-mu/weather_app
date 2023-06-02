//
//  WeatherHomeScreenViewModel.swift
//  Weather App
//
//  Created by Lakshmi Priya on 6/1/23.
//

import Foundation

class WeatherHomeScreenViewModel {
    enum cellType {
        case header, moreInfo
    }
    var cells: [cellType] = []
    var weatherInfoModel: WeatherModel?
    
    let dataManager: WeatherDataManaging
    init(dataManager: WeatherDataManaging) {
        self.dataManager = dataManager
    }
    
    func fetchWeatherInfo(for lat: String, lon:String, callBack:@escaping ((Bool, WeatherError?) -> Void)) {
        dataManager.fetchWeatherInfo(lat: lat, lon: lon) { [weak self ] (response, error) in
           
            guard let weather = response else {
                callBack(false, error)
                return
            }
            self?.updateCellData(weather: weather)
            self?.storeLastusedLatLon(lat, lon)
            callBack(true, nil)
        }
    }
    
    func storeLastusedLatLon(_ lat: String, _ lon:String) {
        UserDefaults.standard.set(lat, forKey: "lat")
        UserDefaults.standard.set(lon, forKey: "lon")
        UserDefaults.standard.synchronize()
    }
    
    
    func lastUsedWeatherInfo() -> (lat: String?, lon: String?) {
        (UserDefaults.standard.string(forKey: "lat"), UserDefaults.standard.string(forKey: "lon"))
    }
    
    func updateCellData(weather: WeatherModel) {
        weatherInfoModel = weather
        cells = []
        if weather.weather.first != nil && weather.main != nil {
            cells.append(.header)
        }
        cells.append(.moreInfo)
    }
   
    
    var numberOfRows: Int {
        return cells.count
    }
    
    var windDetail: String {
        "\(weatherInfoModel?.wind?.speed ?? 0)"
    }
    
    var pressureDetail: String {
        "\(weatherInfoModel?.main?.pressure ?? 0)"
    }
    
    func headerViewModel() -> WeatherDetailCellViewModel {
        let model = WeatherDetailCellViewModel(place: weatherInfoModel?.name ?? "", description: weatherInfoModel?.weather.first?.description ?? "", temparature: "\(weatherInfoModel?.main?.temp ?? 0.0)", high: "\(weatherInfoModel?.main?.temp_max ?? 0.0)", low: "\(weatherInfoModel?.main?.temp_min ?? 0.0)", feelsLike: "\(weatherInfoModel?.main?.feels_like ?? 0.0)", image: weatherInfoModel?.weather.first?.icon)
        
        return model
    }
    
    
}
