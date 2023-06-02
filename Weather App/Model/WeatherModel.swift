//
//  WeatherModel.swift
//  Weather App
//
//  Created by Lakshmi Priya on 6/1/23.
//

import Foundation

struct WeatherModel: Decodable {
    let coord: Coordinates?
    let weather: [CurrentWeather]
    let base: String?
    let main: WeatherDetails?
    let visibility: Int?
    let wind: WindDetails?
    let clouds: CloudDetails?
    let dt: Int?
    let sys: LocationDetails?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
    
    struct LocationDetails: Decodable {
        let type: Int?
        let id: Int?
        let country: String?
        let sunrise: Int?
        let sunset: Int?
    }
    struct CloudDetails: Decodable {
        let all: Int?
        
    }

    struct WindDetails: Decodable {
        let speed: Float?
        let deg: Int?
        let gust: Float?
    }

    struct WeatherDetails: Decodable {
        let temp: Float?
        let feels_like: Float?
        let temp_min: Float?
        let temp_max: Float?
        let pressure: Int?
        let humidity: Int?
        let sea_level: Int?
        let grnd_level: Int?
    }

    struct CurrentWeather: Decodable {
        let id: Int?
        let main: String?
        let description: String?
        let icon: String?
    }

    struct Coordinates: Decodable {
        let lon: Float?
        let lat: Float?
    }
}



