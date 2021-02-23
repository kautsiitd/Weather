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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.startAnimating()
        searchApi.loadData()
    }
}

//MARK:- ApiRespondable
extension SearchPageVC: ApiRespondable {
    func didFetchSuccessfully(for params: [String : AnyHashable]) {
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
        return searchApi.cities?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier) as! SearchCell
        cell.title = searchApi.cities?[indexPath.row].name
        return cell
    }
}

extension SearchPageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let city = searchApi.cities?[indexPath.row] else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let cityWeatherVC = storyboard.instantiateViewController(withIdentifier: "CityWeatherVC") as! CityWeatherVC
        cityWeatherVC.query = city.name
        present(cityWeatherVC, animated: true)
    }
}

//MARK:- UISearchBarDelegate
extension SearchPageVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
