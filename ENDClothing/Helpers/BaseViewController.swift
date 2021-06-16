//
//  BaseViewController.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 16/06/2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    private let loadingIndicator = UIActivityIndicatorView(style: .large)

    func showLoadingIndicator() {
        loadingIndicator.color = .red
        view.addSubview(loadingIndicator)
        loadingIndicator.center = view.center
        loadingIndicator.startAnimating()
    }

    func stopLoadingIndicator() {
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }
}
