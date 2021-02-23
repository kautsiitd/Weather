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
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCities()
        fetchedRC.fetchedObjects?.isEmpty ?? true ? showError(true, with: "No Data") : showError(false)
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

//MARK:- Helpers
extension LikedPageVC {
    private func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 44, right: 0)
    }
    private func fetchCities() {
        let request = CityWeather.fetchAllRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(CityWeather.name), ascending: true)]
        fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context,
                                               sectionNameKeyPath: nil, cacheName: nil)
        do { try fetchedRC.performFetch() }
        catch let error { NSLog(error.localizedDescription) }
    }
}
