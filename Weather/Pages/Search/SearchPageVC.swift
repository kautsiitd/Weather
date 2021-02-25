//
//  SearchPageVC.swift
//  Weather
//
//  Created by Kautsya Kanu on 22/02/21.
//

import UIKit
import CoreData
final class SearchPageVC: BaseViewController {
    //MARK:- Elements
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var tableView: UITableView!
    //MARK:- Properties
    private lazy var searchApi: SearchApi = {
        let searchApi = SearchApi()
        searchApi.delegate = self
        return searchApi
    }()
    private var tableCities: [City] = []
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loader.startAnimating()
        searchApi.loadData()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

//MARK:- ApiRespondable
extension SearchPageVC: ApiRespondable {
    func didFetchSuccessfully(for params: [String : AnyHashable]) {
        tableCities = searchApi.cities ?? []
        loader.stopAnimating()
        tableView.reloadData()
    }
    func didFail(with error: BaseError, for params: [String : AnyHashable]) {
        loader.stopAnimating()
        showError(true, with: "No Data")
    }
}

//MARK:- UITableView
extension SearchPageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableCities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier) as! SearchCell
        cell.city = tableCities[indexPath.row]
        return cell
    }
}

extension SearchPageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = tableCities[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let cityWeatherVC = storyboard.instantiateViewController(withIdentifier: "CityWeatherVC") as! CityWeatherVC
        cityWeatherVC.coords = city.coord
        present(cityWeatherVC, animated: true)
    }
}

//MARK:- UISearchBarDelegate
extension SearchPageVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { [weak self] _ in
            guard let self = self else { return }
            self.tableCities = []
            self.loader.startAnimating()
            self.tableView.reloadData()
            let cities = self.searchApi.cities ?? []
            self.tableCities = searchText.isEmpty ? cities : cities.filter { (city: City) -> Bool in
                // If dataItem matches the searchText, return true to include it
                return city.name.range(of: searchText, options: .caseInsensitive) != nil
            }
            self.tableView.reloadData()
            self.loader.stopAnimating()
        })
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

//MARK:- Helpers
extension SearchPageVC {
    private func setupTableView() {
        tableView.keyboardDismissMode = .onDrag
    }
}
