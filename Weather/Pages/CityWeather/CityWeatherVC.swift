//
//  CityWeatherVC.swift
//  Weather
//
//  Created by Kautsya Kanu on 21/02/21.
//

import UIKit
import CoreLocation
class CityWeatherVC: BaseViewController {
    //MARK:- Elements
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var weatherNameLabel: UILabel!
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var lowestTempLabel: UILabel!
    @IBOutlet private var highestTempLabel: UILabel!
    @IBOutlet private var collectionView: UICollectionView!
    //MARK:- Properties
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }()
    private lazy var api: CurrentWeatherApi = {
        let api = CurrentWeatherApi()
        api.delegate = self
        return api
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loader.startAnimating()
        locationManager.startUpdatingLocation()
    }
}

//MARK:- CollectionView
extension CityWeatherVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        api.cityWeather?.summaryDict.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let summaryCell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherSummaryCell.cellIdentifier, for: indexPath) as! WeatherSummaryCell
        summaryCell.data = api.cityWeather?.summaryDict[indexPath.row]
        return summaryCell
    }
}

extension CityWeatherVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = collectionView.contentInset.left + collectionView.contentInset.right
        let totalWidth = collectionView.frame.width - insets
        return CGSize(width: totalWidth/2, height: 50)
    }
}

//MARK:- CLLocationManagerDelegate
extension CityWeatherVC: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied, .notDetermined, .restricted:
            api.query = "Globe"
            api.makeGetRequest()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default: return
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        api.location = Coordinates(from: locations.last!)
        api.makeGetRequest()
        locationManager.stopUpdatingLocation()
    }
}

//MARK:- ApiRespondable
extension CityWeatherVC: ApiRespondable {
    func didFetchSuccessfully(for params: [String : AnyHashable]) {
        guard let cityWeather = api.cityWeather else { loader.stopAnimating(); return }
        cityNameLabel.text = cityWeather.name
        weatherNameLabel.text = cityWeather.weather.first?.main
        temperatureLabel.text = "\(cityWeather.main.temp.i)°"
        lowestTempLabel.text = "L: \(cityWeather.main.tempMin.i)°"
        highestTempLabel.text = "H: \(cityWeather.main.tempMax.i)°"
        collectionView.reloadData()
        loader.stopAnimating()
    }
    func didFail(with error: BaseError, for params: [String : AnyHashable]) {
        loader.stopAnimating()
    }
}

//MARK:- Helpers
extension CityWeatherVC {
    private func setupCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 18, bottom: 18, right: 18)
    }
}
