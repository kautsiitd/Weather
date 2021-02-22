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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoader()
    }
}

extension BaseViewController {
    private func setupLoader() {
        loader.hidesWhenStopped = true
        view.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
