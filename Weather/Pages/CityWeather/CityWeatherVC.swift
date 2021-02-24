//
//  CityWeatherVC.swift
//  Weather
//
//  Created by Kautsya Kanu on 21/02/21.
//

import UIKit
import CoreLocation
import CoreData
final class CityWeatherVC: BaseViewController {
    //MARK:- Elements
    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var weatherNameLabel: UILabel!
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var lowestTempLabel: UILabel!
    @IBOutlet private var highestTempLabel: UILabel!
    @IBOutlet private var aqiView: UIView!
    @IBOutlet private var aqiSlider: UIView!
    @IBOutlet private var aqiMarkView: UIView!
    @IBOutlet private var aqiLabel: UILabel!
    @IBOutlet private var forecastCV: UICollectionView!
    @IBOutlet private var currentInfoCV: UICollectionView!
    //MARK:- Constraints
    @IBOutlet private var aqiMarkPos: NSLayoutConstraint!
    //MARK:- Properties
    private let context = CoreDataManager.shared.container.viewContext
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }()
    private lazy var currentApi: CurrentWeatherApi = {
        let currentApi = CurrentWeatherApi()
        currentApi.delegate = self
        return currentApi
    }()
    private lazy var forecastApi: ForecastApi = {
        let forecastApi = ForecastApi()
        forecastApi.delegate = self
        return forecastApi
    }()
    private lazy var pollutionApi: PollutionApi = {
        let pollutionApi = PollutionApi()
        pollutionApi.delegate = self
        return pollutionApi
    }()
    var query: String? { didSet {
        loader.startAnimating()
        currentApi.query = query
        currentApi.makeGetRequest()
        forecastApi.query = query
        forecastApi.makeGetRequest()
    }}
    var location: CLLocation? { didSet {
        guard let location = location else { return }
        loader.startAnimating()
        let coords = Coordinates(from: location)
        currentApi.location = coords
        currentApi.makeGetRequest()
        forecastApi.location = coords
        forecastApi.makeGetRequest()
        pollutionApi.location = coords
        pollutionApi.makeGetRequest()
        locationManager.stopUpdatingLocation()
    }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerForNotifications()
        loader.startAnimating()
        locationManager.startUpdatingLocation()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aqiSlider.addGradiant(of: [.green, .yellow, .orange, .red, .brown],
                            from: .pos(.mid, .left), to: .pos(.mid, .right))
    }
}

//MARK:- IBActions
extension CityWeatherVC {
    @IBAction private func toggleLike() {
        guard let cityWeather = currentApi.cityWeather else { return }
        likeButton.animatePop()
        likeButton.isSelected = !likeButton.isSelected
        do { likeButton.isSelected ? try cityWeather.save(to: context) :
                                     try cityWeather.delete(from: context) }
        catch let error {
            likeButton.isSelected = !likeButton.isSelected
            NSLog(error.localizedDescription)
        }
    }
}

//MARK:- CollectionView
extension CityWeatherVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == forecastCV { return forecastApi.forecast?.list.count ?? 0 }
        else if collectionView == currentInfoCV { return currentApi.cityWeather?.summaryDict.count ?? 0 }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == forecastCV {
            let forecastCell = forecastCV.dequeueReusableCell(withReuseIdentifier: CityForecastCell.cellIdentifier, for: indexPath) as! CityForecastCell
            forecastCell.data = forecastApi.forecast?.list[indexPath.row]
            return forecastCell
        } else if collectionView == currentInfoCV {
            let summaryCell = currentInfoCV.dequeueReusableCell(withReuseIdentifier: WeatherSummaryCell.cellIdentifier, for: indexPath) as! WeatherSummaryCell
            summaryCell.data = currentApi.cityWeather?.summaryDict[indexPath.row]
            return summaryCell
        }
        return UICollectionViewCell()
    }
}

extension CityWeatherVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == forecastCV {
            let cellHeight = 10+21+20+25+20+24+10
            return CGSize(width: 60, height: cellHeight)
        } else if collectionView == currentInfoCV {
            let insets = currentInfoCV.contentInset.left + currentInfoCV.contentInset.right
            let totalWidth = currentInfoCV.frame.width - insets
            return CGSize(width: totalWidth/2, height: 50)
        }
        return .zero
    }
}

//MARK:- CLLocationManagerDelegate
extension CityWeatherVC: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied, .notDetermined, .restricted:
            query = "Globe"
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default: return
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last!
    }
}

//MARK:- ApiRespondable
extension CityWeatherVC: ApiRespondable {
    func didFetchSuccessfully(for params: [String : AnyHashable]) {
        switch params["ApiType"] as? String {
        case currentApi.id: refreshView()
        case forecastApi.id: forecastCV.reloadData()
        case pollutionApi.id:
            guard let pollution = pollutionApi.cityPollution?.list.first else { return }
            aqiLabel.text = pollution.main.aqiName
            aqiView.layoutIfNeeded()
            aqiMarkPos.constant = aqiSlider.bounds.width * pollution.main.relativePos
            UIView.animate(withDuration: 0.8) { self.aqiSlider.layoutIfNeeded() }
        default: return
        }
        likeButton.isHidden = false
        loader.stopAnimating()
    }
    func didFail(with error: BaseError, for params: [String : AnyHashable]) {
        switch params["ApiType"] as? String {
        case currentApi.id: showError(true, with: error.localizedDescription)
        case forecastApi.id: NSLog("ForecastApi Failed: \(error.localizedDescription)"); return
        case pollutionApi.id: NSLog("PollutionApi Failed: \(error.localizedDescription)"); return
        default: return
        }
        likeButton.isHidden = true
        loader.stopAnimating()
    }
}

//MARK:- Notifications
extension CityWeatherVC {
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(libraryUpdated), name: Notifications.libraryUpdated.name, object: nil)
    }
    @objc private func libraryUpdated(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let cityName = userInfo["cityName"] as? String, let status = userInfo["status"] as? String
        else { return }
        if cityName != currentApi.cityWeather?.name { return }
        likeButton.isSelected = status == "added"
    }
}

//MARK:- Helpers
extension CityWeatherVC {
    private func setupView() {
        likeButton.isHidden = true
        setupLikeButton()
        setupAqiView()
        setupCollectionView()
    }
    private func setupLikeButton() {
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
    }
    private func setupAqiView() {
        aqiSlider.layer.cornerRadius = aqiSlider.bounds.height/2
        aqiMarkView.layer.borderWidth = 2
        aqiMarkView.layer.borderColor = UIColor.black.cgColor
        aqiMarkView.layer.cornerRadius = aqiMarkView.bounds.height/2
    }
    private func setupCollectionView() {
        forecastCV.contentInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        currentInfoCV.contentInset = UIEdgeInsets(top: 0, left: 18, bottom: 18, right: 18)
    }
    private func refreshView() {
        guard let cityWeather = currentApi.cityWeather else { loader.stopAnimating(); return }
        cityNameLabel.text = cityWeather.name
        weatherNameLabel.text = cityWeather.weather.first?.main
        temperatureLabel.text = "\(cityWeather.main.temp.i)°"
        lowestTempLabel.text = "L: \(cityWeather.main.tempMin.i)°"
        highestTempLabel.text = "H: \(cityWeather.main.tempMax.i)°"
        currentInfoCV.reloadData()
        likeButton.isSelected = cityWeather.isPresent(in: context)
    }
}
