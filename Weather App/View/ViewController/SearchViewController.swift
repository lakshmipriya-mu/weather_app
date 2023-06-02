//
//  SearchViewController.swift
//  Weather App
//
//  Created by Lakshmi Priya on 6/1/23.
//

import UIKit

class SearchViewController: UIViewController {
    var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var searchBar: UISearchBar = {
        let searchView = UISearchBar()
        searchView.frame = CGRect(x: 0, y: 0, width: 200, height: 70)
        searchView.showsCancelButton = true
        searchView.searchBarStyle = UISearchBar.Style.default
        searchView.placeholder = "Enter your location to search"
        searchView.sizeToFit()
        return searchView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
    }
    
    func setupTableView() {
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = searchBar
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "locationCell") ??
        UITableViewCell(style: .default, reuseIdentifier: "locationCell")
        let data = viewModel.item(for: indexPath.row)
        cell.textLabel?.text = "\(data.name), \(data.state ?? ""), \(data.country ?? "")"
        return cell
    }
    
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.item(for: indexPath.row)
        viewModel.callback(data.lat, data.lon)
        self.dismiss(animated: true)
    }
}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        let text =  searchBar.text
        if !(text?.isEmpty ?? true) {
            viewModel.getLocations(for: text ?? "") { [weak self] (result, error) in
                guard let strongSelf = self else { return }
                if result {
                    DispatchQueue.main.async {
                        strongSelf.tableView.reloadData()
                    }
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
        searchBar.endEditing(true)
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true)
    }
}


