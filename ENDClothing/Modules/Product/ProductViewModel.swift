//
//  ProductViewModel.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 14/06/2021.
//

import UIKit

enum ProductCellType {
    case imageCell(image: UIImage?, titles: [[String]])
    case descriptionCell(title: String, heading: String?, description: String)
}

protocol ProductViewModelProtocol {
    var navTitle: String { get }
    var cells: [ProductCellType] { get }
}

final class ProductViewModel: ProductViewModelProtocol {
    
    // MARK: - Properties
    
    let navTitle: String
    let cells: [ProductCellType] = [
        .imageCell(image: UIImage(named: "tshirtPlaceholder"), titles: [["UK 4", "UK 5", "UK 6"], ["UK 7", "UK 8", "UK 9"], ["UK 10", "UK 11", "UK 12"]]),
        .descriptionCell(title: "DESCRIPTION",
                         heading: nil,
                         description: "ENDClothing worked with some of the fastest athletes on the planet to create these running shoes. The ultralight upper has an internal fit system that reduces pressure and provides lockdown. The Carbitex carbon plate adds propulsion for effortless forward movement. Fast isn't just for the world's best. Fast was made for you too."),
        .descriptionCell(title: "SHIPPING",
                         heading: "United Kingdom",
                         description: "• £3.99 DPD 2-3 Day Stardard Service.\n• £5.99 DPD Next Working Day Priority Service.\n• Free DPD 2-3 Day Standard Service on orders over £150.00.")
    ]
    
    // MARK: - Initialization
    
    init(product: Product) {
        navTitle = product.name
    }
}
