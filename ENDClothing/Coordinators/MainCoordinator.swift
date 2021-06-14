//
//  MainCoordinator.swift
//  SpaceXRockets
//
//  Created by Pablo Ortiz Rodríguez on 2/6/21.
//

import UIKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get set }
    func start()
}

// MARK: - CoordinatorProtocol

final class MainCoordinator: CoordinatorProtocol {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func start() {
        showCatalogScreen()
    }
}

// MARK: - Private helpers

extension MainCoordinator {

    private func showCatalogScreen() {
        let viewController = CatalogViewController(viewModel: CatalogViewModel(coordinator: self))
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - CatalogCoordinatorProtocol

extension MainCoordinator: CatalogCoordinatorProtocol {
    
    func onContinue(product: Product) {
        let viewController = ProductViewController(viewModel: ProductViewModel(product: product))
        navigationController.pushViewController(viewController, animated: true)
    }
}
