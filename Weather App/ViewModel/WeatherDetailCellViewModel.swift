//
//  HeaderTableViewCellViewModel.swift
//  Weather App
//
//  Created by Lakshmi Priya on 6/1/23.
//

import Foundation

struct WeatherDetailCellViewModel {
    let place: String
    let description: String
    let temparature: String
    let high: String
    let low: String
    let feelsLike: String
    let image: String?
    var imageUrl: URL? {
        if let image = image {
            return URL(string: WeatherAppConfig.imageUrl.rawValue + image + "@2x.png")
        }
        return nil
    }
    
    var feelsLikeText: String {
        return "feels like: \(feelsLike)°"
    }
    
    var currentTemparature: String {
        return "\(temparature)°"
    }
    
    
    var moreInfoLabel: String {
        return "H: \(high)° L: \(low)°"
    }
}
