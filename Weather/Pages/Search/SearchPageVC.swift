//
//  SearchPageVC.swift
//  Weather
//
//  Created by Kautsya Kanu on 22/02/21.
//

import UIKit
class SearchPageVC: BaseViewController {
    //MARK:- Elements
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var tableView: UITableView!
    //MARK:- Properties
}

extension SearchPageVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
