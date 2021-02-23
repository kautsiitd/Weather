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
    private let data: [String] = ["Delhi", "Mumbai", "London", "Bangalore"]
}

//MARK:- UITableView
extension SearchPageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier) as! SearchCell
        cell.title = data[indexPath.row]
        return cell
    }
}

extension SearchPageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let cityWeatherVC = storyboard.instantiateViewController(withIdentifier: "CityWeatherVC") as! CityWeatherVC
        cityWeatherVC.query = data[indexPath.row]
        present(cityWeatherVC, animated: true)
    }
}

//MARK:- UISearchBarDelegate
extension SearchPageVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
