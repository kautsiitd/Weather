//
//  BaseViewController.swift
//  Weather
//
//  Created by Kautsya Kanu on 22/02/21.
//

import UIKit
class BaseViewController: UIViewController {
    //MARK:- Elements
    var loader: UIActivityIndicatorView = UIActivityIndicatorView()
    var errorLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoader()
        setupErrorView()
    }
}

//MARK:- Available Functions
extension BaseViewController {
    func showError(_ shouldShow: Bool, with message: String = "") {
        errorLabel.isHidden = !shouldShow
        errorLabel.text = message
    }
}

//MARK:- Helpers
extension BaseViewController {
    private func setupLoader() {
        loader.hidesWhenStopped = true
        loader.style = .medium
        view.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    private func setupErrorView() {
        view.addSubview(errorLabel)
        errorLabel.font = .systemFont(ofSize: 18, weight: .medium)
        errorLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        errorLabel.isHidden = true
    }
}
