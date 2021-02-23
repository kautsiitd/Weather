//
//  CityForecastCell.swift
//  Weather
//
//  Created by Kautsya Kanu on 23/02/21.
//

import UIKit
class CityForecastCell: UICollectionViewCell {
    //MARK:- Elements
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var tempLabel: UILabel!
    //MARK:- Properties
    static let cellIdentifier: String = "\(CityForecastCell.self)"
    var data: ForecastWeather.WeatherDayDetail? {
        didSet { refreshView() }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        data = nil
    }
}

//MARK:- Helpers
extension CityForecastCell {
    private func refreshView() {
    }
}
