//
//  WeatherHomeScreenController.swift
//  Weather App
//
//  Created by Lakshmi Priya on 6/1/23.
//

import UIKit
import CoreLocation

class WeatherHomeScreenController: UITableViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    let viewModel = WeatherHomeScreenViewModel(dataManager: WeatherDataManager())
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = "Search for any location?"
        title = "Weather App"
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
        
    func setupLocation() {
        let (lat, lon) = viewModel.lastUsedWeatherInfo()
        if let lat = lat, let lon = lon {
            requestWeatherForLocation(lat: Double(lat), lon: Double(lon))
            return
        }
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            if let currentLocation = locations.first{
                locationManager.startUpdatingLocation()
                requestWeatherForLocation(lat: currentLocation.coordinate.latitude, lon: currentLocation.coordinate.longitude)
            }
        default:
            DispatchQueue.main.async { [weak self] in
                self?.showAlert("Please go to setting to enable location")
            }
        }
    }
    
    func requestWeatherForLocation(lat: Double?, lon: Double?) {
       
        viewModel.fetchWeatherInfo(for: String(lat ?? 0.0), lon: String(lon ?? 0.0) ){ (result, error) in
            DispatchQueue.main.async {[weak self] in
                guard let strongSelf = self else { return }
                if result {
                    strongSelf.tableView.reloadData()
                }else {
                    switch error {
                    case .serviceError:
                        strongSelf.showAlert("Service Error!")
                    case . connectionError:
                        strongSelf.showAlert("Please check network!")
                    case .parseError, .urlError:
                        strongSelf.showAlert("Application Error!")
                    case .none:
                        strongSelf.showAlert("Nothing working now, please try again later!")
                    }
                }
            }
        }
       
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
//    TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = viewModel.cells[indexPath.row]
        switch cellType {
        case .header:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as? WeatherDetailTableCell {
                cell.configure(data: viewModel.headerViewModel())
                return cell
            }
        case .moreInfo:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MoreInfoTableViewCell", for: indexPath) as? MoreInfoTableViewCell {
                cell.configure(wind: viewModel.windDetail, pressure: viewModel.pressureDetail)
                return cell
            }
        }
       
        return UITableViewCell()
        
    }
 
    
}




//    Searchbar
extension WeatherHomeScreenController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        goToSearchScreen()
        return false
    }
    
    func goToSearchScreen() {
        let searchViewModel = SearchViewModel(dataManager: WeatherDataManager()) { (lat: Double, lon: Double) in
            self.requestWeatherForLocation(lat: lat, lon: lon)
        }
        let controller = SearchViewController(viewModel: searchViewModel)
        self.present(controller, animated: true)

    }
}




