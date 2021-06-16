//
//  ProductViewModelTests.swift
//  ENDClothingTests
//
//  Created by Pablo Ortiz on 16/06/2021.
//

import XCTest
@testable import ENDClothing

final class ProductViewModelTests: XCTestCase {
    
    private let productJson = """
        {
            "name": "T-shirt",
            "price": "£50",
            "image": "https://media.endclothing.com/media/f_auto,q_auto,w_760,h_760/prodmedia/media/catalog/product/2/6/26-03-2018_gosha_rubchinskiyxadidas_copaprimeknitboostmidsneaker_yellow_g012sh12-220_ka_1.jpg"
        }
    """
    
    private lazy var product: Product? = {
        guard let data = productJson.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(Product.self, from: data)
    }()
    
    func testViewModelOutputs() {
        guard let product = product else {
            XCTFail("Incorrect data model")
            return
        }
        let viewModel = makeSUT(product: product)
        XCTAssertEqual(viewModel.navTitle, "T-shirt")
        XCTAssertEqual(viewModel.cells.count, 3)
        // First cell
        guard case .imageCell(let image, let titles) = viewModel.cells[0] else {
            XCTFail("incorrect cell")
            return
        }
        XCTAssertEqual(image, UIImage(named: "tshirtPlaceholder"))
        XCTAssertEqual(titles, [["UK 4", "UK 5", "UK 6"], ["UK 7", "UK 8", "UK 9"], ["UK 10", "UK 11", "UK 12"]])
        
        // Second cell
        guard case .descriptionCell(let title, let heading, let description) = viewModel.cells[1] else {
            XCTFail("incorrect cell")
            return
        }
        XCTAssertEqual(title, "DESCRIPTION")
        XCTAssertNil(heading)
        XCTAssertEqual(description, "ENDClothing worked with some of the fastest athletes on the planet to create these running shoes. The ultralight upper has an internal fit system that reduces pressure and provides lockdown. The Carbitex carbon plate adds propulsion for effortless forward movement. Fast isn't just for the world's best. Fast was made for you too.")
        
        // Third cell
        guard case .descriptionCell(let title, let heading, let description) = viewModel.cells[2] else {
            XCTFail("incorrect cell")
            return
        }
        XCTAssertEqual(title, "SHIPPING")
        XCTAssertEqual(heading, "United Kingdom")
        XCTAssertEqual(description, "• £3.99 DPD 2-3 Day Stardard Service.\n• £5.99 DPD Next Working Day Priority Service.\n• Free DPD 2-3 Day Standard Service on orders over £150.00.")
    }
}

// MARK: - Private helpers

extension ProductViewModelTests {
    
    private func makeSUT(product: Product) -> ProductViewModel {
        return ProductViewModel(product: product)
    }
}
