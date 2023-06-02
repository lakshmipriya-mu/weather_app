//
//  GeoCodeMapingModel.swift
//  Weather App
//
//  Created by Lakshmi Priya on 6/1/23.
//

import Foundation
struct GeoCodeMapingModel: Decodable {
    let name: String
    let lat: Double
    let lon: Double
    let state: String?
    let country: String?
}
