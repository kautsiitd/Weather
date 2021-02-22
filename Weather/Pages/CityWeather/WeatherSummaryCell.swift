//
//  WeatherSummaryCell.swift
//  Weather
//
//  Created by Kautsya Kanu on 22/02/21.
//

import UIKit
class WeatherSummaryCell: UICollectionViewCell {
    //MARK:- Elements
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var valueLabel: UILabel!
    //MARK:- Properties
    static let cellIdentifier: String = "\(WeatherSummaryCell.self)"
    var data: KeyValueString? {
        didSet { refreshView() }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        data = nil
    }
}

//MARK:- Helpers
extension WeatherSummaryCell {
    private func refreshView() {
        titleLabel.text = data?.key
        valueLabel.text = data?.value
    }
}
