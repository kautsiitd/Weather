//
//  LikedCityCell.swift
//  Weather
//
//  Created by Kautsya Kanu on 23/02/21.
//

import UIKit
class LikedCityCell: UITableViewCell {
    //MARK:- Elements
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var tempLabel: UILabel!
    //MARK:- Properties
    static let identifier: String = "\(LikedCityCell.self)"
    var cityWeather: CityWeather? {
        didSet { refreshView() }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityWeather = nil
    }
}

//MARK:- Helpers
extension LikedCityCell {
    private func refreshView() {
        if let cityWeather = cityWeather {
            titleLabel.text = cityWeather.name
            tempLabel.text = "\(cityWeather.temp.i)°"
        } else {
            titleLabel.text = ""
            tempLabel.text = "--°"
        }
    }
}
