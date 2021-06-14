//
//  ProductViewController.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 14/06/2021.
//

import UIKit

final class ProductViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: ProductViewModelProtocol
    
    // MARK: - Initialization
    
    init(viewModel: ProductViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.navTitle
        view.backgroundColor = .white
    }
}
