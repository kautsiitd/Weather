//
//  CityForecastCell.swift
//  Weather
//
//  Created by Kautsya Kanu on 23/02/21.
//

import UIKit
final class CityForecastCell: UICollectionViewCell {
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
        if let data = data {
            let date = data.dtTxt.date
            timeLabel.text = date?.string(in: "h a")
            iconImageView.image = date?.symbol
            iconImageView.tintColor = date?.symbolColor
            tempLabel.text = "\(data.main.temp.rounded().i)°"
        } else {
            timeLabel.text = ""
            iconImageView.image = nil
            tempLabel.text = ""
        }
    }
}
