//
//  SearchCell.swift
//  Weather
//
//  Created by Kautsya Kanu on 23/02/21.
//

import UIKit
final class SearchCell: UITableViewCell {
    //MARK:- Elements
    @IBOutlet private var titleLabel: UILabel!
    //MARK:- Properties
    static let identifier: String = "\(SearchCell.self)"
    var city: City? {
        didSet { refreshView() }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        city = nil
    }
}

extension SearchCell {
    private func refreshView() {
        guard let city = city else { titleLabel.text = ""; return }
        titleLabel.text = "\(city.name), \(city.country)"
    }
}
