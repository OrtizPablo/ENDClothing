//
//  ProductViewModel.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 14/06/2021.
//

protocol ProductViewModelProtocol {
    var navTitle: String { get }
}

final class ProductViewModel: ProductViewModelProtocol {
    
    // MARK: - Properties
    
    let navTitle: String
    
    // MARK: - Initialization
    
    init(product: Product) {
        navTitle = product.name
    }
}
