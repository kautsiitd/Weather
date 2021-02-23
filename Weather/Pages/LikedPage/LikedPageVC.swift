//
//  LikedPageVC.swift
//  Weather
//
//  Created by Kautsya Kanu on 22/02/21.
//

import UIKit
import CoreData
class LikedPageVC: BaseViewController {
    //MARK:- Properties
    private let context = CoreDataManager.shared.container.viewContext
    private var fetchedRC: NSFetchedResultsController<CityWeather>!
    //MARK:- Elements
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerForNotifications()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshView()
    }
}

//MARK: UITableViewDataSource
extension LikedPageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedRC.fetchedObjects?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LikedCityCell.identifier) as! LikedCityCell
        cell.cityWeather = fetchedRC.object(at: indexPath)
        return cell
    }
}

extension LikedPageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let cityWeatherVC = storyboard.instantiateViewController(withIdentifier: "CityWeatherVC") as! CityWeatherVC
        cityWeatherVC.query = fetchedRC.object(at: indexPath).name
        present(cityWeatherVC, animated: true)
    }
}

//MARK:- Notifications
extension LikedPageVC {
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(libraryUpdated), name: Notifications.libraryUpdated.name, object: nil)
    }
    @objc private func libraryUpdated(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let _ = userInfo["cityName"] as? String, let _ = userInfo["status"] as? String
        else { return }
        refreshView()
    }
}

//MARK:- Helpers
extension LikedPageVC {
    private func setupView() {
        errorLabel.textColor = .white
        setupTableView()
    }
    private func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    private func fetchCities() {
        let request = CityWeather.fetchAllRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(CityWeather.name), ascending: true)]
        fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context,
                                               sectionNameKeyPath: nil, cacheName: nil)
        do { try fetchedRC.performFetch() }
        catch let error { NSLog(error.localizedDescription) }
    }
    private func refreshView() {
        fetchCities()
        tableView.reloadData()
        fetchedRC.fetchedObjects?.isEmpty ?? true ? showError(true, with: "No Data") : showError(false)
    }
}
