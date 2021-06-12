//
//  CatalogViewModel.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 12/06/2021.
//

import Combine

protocol CatalogViewModelProtocol {
    var products: CurrentValueSubject<[Product], Never> { get }
}

final class CatalogViewModel: CatalogViewModelProtocol {
    
    // MARK: - Properties
    
    private let productRepository: ProductRepositoryProtocol
    
    let products = CurrentValueSubject<[Product], Never>([])
    
    // MARK: - Initialization
    
    init(productRepository: ProductRepositoryProtocol = ProductRepository()) {
        self.productRepository = productRepository
        getProducts()
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
}
