//
//  CatalogViewModel.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 12/06/2021.
//

import Combine

protocol CatalogCoordinatorProtocol: AnyObject {
    func onContinue(product: Product)
}

protocol CatalogViewModelProtocol {
    var navTitle: String { get }
    var products: CurrentValueSubject<[Product], Never> { get }
    var onProductTapped: PassthroughSubject<Int, Never> { get }
}

final class CatalogViewModel: CatalogViewModelProtocol {
    
    // MARK: - Properties
    
    private let productRepository: ProductRepositoryProtocol
    
    let navTitle = "Products"
    let products = CurrentValueSubject<[Product], Never>([])
    let onProductTapped = PassthroughSubject<Int, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    private weak var coordinator: CatalogCoordinatorProtocol?
    
    // MARK: - Initialization
    
    init(coordinator: CatalogCoordinatorProtocol,
         productRepository: ProductRepositoryProtocol = ProductRepository()) {
        self.coordinator = coordinator
        self.productRepository = productRepository
        getProducts()
        bindings()
    }
}

// MARK: - Private helpers

extension CatalogViewModel {
    
    private func getProducts() {
        productRepository.getProducts { [weak self] result in
            switch result {
            case .success(let products):
                self?.products.value = products
            case .failure:
                // TODO: show error on screen
                break
            }
        }
    }
    
    private func bindings() {
        onProductTapped.sink { [weak self] index in
            guard let self = self else { return }
            let product = self.products.value[index]
            self.coordinator?.onContinue(product: product)
        }.store(in: &cancellables)
    }
}
