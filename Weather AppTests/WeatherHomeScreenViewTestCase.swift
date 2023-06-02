//
//  WeatherHomeScreenViewTestCase.swift
//  Weather AppTests
//
//  Created by Lakshmi Priya on 6/1/23.
//

import XCTest
@testable import Weather_App

final class WeatherHomeScreenViewModelTestCase: XCTestCase {

    func testNumberOfRows() {
        let viewModel = WeatherHomeScreenViewModel(dataManager: WeatherMockDataManager())
        viewModel.fetchWeatherInfo(for: "34.4423", lon: "55.999") { (result, error)  in
            XCTAssertTrue(result)
            XCTAssertEqual(viewModel.numberOfRows, 2)
        }
    }

    
    func testWindDetail() {
        let viewModel = WeatherHomeScreenViewModel(dataManager: WeatherMockDataManager())
        viewModel.fetchWeatherInfo(for: "34.4423", lon: "55.999") { (result, error) in
            XCTAssertTrue(result)
            XCTAssertEqual(viewModel.windDetail, "0.62")
        }
    }
    
    func testPressureDetail() {
        let viewModel = WeatherHomeScreenViewModel(dataManager: WeatherMockDataManager())
        viewModel.fetchWeatherInfo(for: "34.4423", lon: "55.999") { (result, error) in
            XCTAssertTrue(result)
            XCTAssertEqual(viewModel.pressureDetail, "1015")
        }
    }
    
    func testHeaderModel() {
        let viewModel = WeatherHomeScreenViewModel(dataManager: WeatherMockDataManager())
        viewModel.fetchWeatherInfo(for: "34.4423", lon: "55.999") { (result, error) in
            XCTAssertTrue(result)
            XCTAssertEqual(viewModel.headerViewModel().currentTemparature, "298.48°")
            XCTAssertEqual(viewModel.headerViewModel().moreInfoLabel, "H: 300.05° L: 297.56°")
            XCTAssertEqual(viewModel.headerViewModel().feelsLikeText, "feels like: 298.74°")
        }
    }
    
    func testLastUsedWeatherInfo() {
        let viewModel = WeatherHomeScreenViewModel(dataManager: WeatherMockDataManager())
        viewModel.fetchWeatherInfo(for: "34.4423", lon: "55.999") { (result, error) in
            XCTAssertTrue(result)
            let (lat, lon) = viewModel.lastUsedWeatherInfo()
            XCTAssertEqual(lat, "34.4423")
            XCTAssertEqual(lon, "55.999")
        }
    }
  

}
