//
//  ProductViewController.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 14/06/2021.
//

import UIKit

final class ProductViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ProductViewCell.self, forCellReuseIdentifier: "ProductViewCell")
        tableView.register(ProductDescriptionViewCell.self, forCellReuseIdentifier: "ProductDescriptionViewCell")
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "ProductTableView"
        return tableView
    }()
    
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
        tableView.pin(to: view)
    }
}

// MARK: - UITableViewDataSource

extension ProductViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.cells[indexPath.row] {
        case .imageCell(let imagePath, let titles):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductViewCell") as? ProductViewCell else {
                return UITableViewCell()
            }
            cell.setupCell(imagePath: imagePath, titles: titles)
            cell.selectionStyle = .none
            cell.contentView.isUserInteractionEnabled = false
            return cell
        case .descriptionCell(let title, let heading, let description):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDescriptionViewCell") as? ProductDescriptionViewCell else {
                return UITableViewCell()
            }
            cell.setupCell(title: title, heading: heading, description: description)
            cell.selectionStyle = .none
            cell.contentView.isUserInteractionEnabled = false
            return cell
        }
    }
}
