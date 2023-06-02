//
//  DataManager.swift
//  Weather App
//
//  Created by Lakshmi Priya on 6/1/23.
//

import Foundation
protocol WeatherDataManaging {
    func geoCodeApi(location: String, callback: @escaping(([GeoCodeMapingModel]?, WeatherError?) ->Void))
    func fetchWeatherInfo(lat: String, lon: String, callback: @escaping((WeatherModel?, WeatherError?) ->Void))

}

class WeatherDataManager: WeatherDataManaging {
    private let apiKey = "e8d9a8e51b28b900f98e2d5ffe99753a"
    
    func geoCodeApi(location: String, callback: @escaping (([GeoCodeMapingModel]?, WeatherError?) -> Void)) {
        let url = WeatherAppConfig.geoCodeApiUrl.rawValue + "?q=\(location)&appid=\(apiKey)&limit=5"
        guard let url = URL(string: url) else {
            callback(nil, .urlError)
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            
            guard let data = data, error == nil else {
                callback(nil, .serviceError)
                return
            }
            
            var json: [GeoCodeMapingModel]?
            do {
                json = try JSONDecoder().decode([GeoCodeMapingModel].self, from: data)
            }
            catch {
                callback(nil, .parseError)
            }
            
            guard let result = json else {
                return
            }
            callback(result, nil)
            
        }).resume()
    }
    
    func fetchWeatherInfo(lat: String, lon: String, callback: @escaping ((WeatherModel?, WeatherError?) -> Void)) {
        let url = WeatherAppConfig.weatherUrl.rawValue + "?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=imperial"
        guard let url = URL(string: url) else {
            callback(nil, .urlError)
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
        
            guard let data = data, error == nil else {
                callback(nil, .serviceError)
                return
            }
            
            var json: WeatherModel?
            do {
                json = try JSONDecoder().decode(WeatherModel.self, from: data)
            }
            catch {
                callback(nil, .parseError)
            }
            
            guard let result = json else {
                return
            }
            callback(result, nil)
            
        }).resume()
    }
    
}
