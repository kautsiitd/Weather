//
//  SearchCell.swift
//  Weather
//
//  Created by Kautsya Kanu on 23/02/21.
//

import UIKit
class SearchCell: UITableViewCell {
    //MARK:- Elements
    @IBOutlet private var titleLabel: UILabel!
    //MARK:- Properties
    static let identifier: String = "\(SearchCell.self)"
    var title: String? {
        didSet { refreshView() }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title = nil
    }
}

extension SearchCell {
    private func refreshView() {
        titleLabel.text = title
    }
}
