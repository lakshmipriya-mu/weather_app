//
//  WeatherError.swift
//  Weather App
//
//  Created by Lakshmi Priya on 6/1/23.
//

import Foundation
enum WeatherError: Error {
    case serviceError
    case connectionError
    case parseError
    case urlError
}
