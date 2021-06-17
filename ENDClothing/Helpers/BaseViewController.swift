//
//  BaseViewController.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 16/06/2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private(set) var placeholderView = PlaceholderView()

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
    
    func showPlaceholder() {
        view.addSubview(placeholderView)
        placeholderView.pin(to: view)
        view.bringSubviewToFront(placeholderView)
    }

    func hidePlaceholder() {
        placeholderView.removeFromSuperview()
    }
}
