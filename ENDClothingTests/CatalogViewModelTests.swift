//
//  CatalogViewModelTests.swift
//  ENDClothingTests
//
//  Created by Pablo Ortiz on 08/06/2021.
//

import XCTest
@testable import ENDClothing
import Combine

final class CatalogViewModelTests: XCTestCase {
    
    private var sutSpy: CatalogViewModelSpy!
    
    func testLoadProductsSuccessfully() {
        _ = makeSUT(productRepository: MockProductRepository())
        XCTAssertEqual(sutSpy.products.count, 2)
        assertProductInfo(product: sutSpy.products[0], name: "T-shirt", price: "£50", imagePath: "https://media.endclothing.com/media/f_auto,q_auto,w_760,h_760/prodmedia/media/catalog/product/2/6/26-03-2018_gosha_rubchinskiyxadidas_copaprimeknitboostmidsneaker_yellow_g012sh12-220_ka_1.jpg")
        assertProductInfo(product: sutSpy.products[1], name: "Shirt", price: "£100", imagePath: "https://media.endclothing.com/media/f_auto,q_auto,w_760,h_760/prodmedia/media/catalog/product/2/6/26-03-2018_gosha_rubchinskiyxadidas_copaprimeknitboostmidsneaker_yellow_g012sh12-220_ka_1.jpg")
    }
    
    func testLoadProductsFailure() {
        let productsRepo = MockProductRepository()
        productsRepo.shouldFail = true
        _ = makeSUT(productRepository: productsRepo)
        XCTAssertEqual(sutSpy.products.count, 0)
    }
}

// MARK: - Private helpers

extension CatalogViewModelTests {
    
    private func makeSUT(productRepository: ProductRepositoryProtocol) -> CatalogViewModel {
        sutSpy = CatalogViewModelSpy()
        let sut = CatalogViewModel(productRepository: productRepository)
        sutSpy.attach(to: sut)
        return sut
    }
    
    private func assertProductInfo(product: Product, name: String, price: String, imagePath: String) {
        XCTAssertEqual(product.name, name)
        XCTAssertEqual(product.price, price)
        XCTAssertEqual(product.imagePath, imagePath)
    }
}

// MARK: - CatalogViewModelSpy

private final class CatalogViewModelSpy {
    
    var products = [Product]()
    private var cancellables = Set<AnyCancellable>()
    
    func attach(to sut: CatalogViewModel) {
        sut.products
            .assign(to: \.products, on: self)
            .store(in: &cancellables)
    }
}

// MARK: - MockProductRepository

private final class MockProductRepository: ProductRepositoryProtocol {
    
    var shouldFail = false
    
    private let productsJson = """
        [
            {
                "name": "T-shirt",
                "price": "£50",
                "image": "https://media.endclothing.com/media/f_auto,q_auto,w_760,h_760/prodmedia/media/catalog/product/2/6/26-03-2018_gosha_rubchinskiyxadidas_copaprimeknitboostmidsneaker_yellow_g012sh12-220_ka_1.jpg"
            },
            {
                "name": "Shirt",
                "price": "£100",
                "image": "https://media.endclothing.com/media/f_auto,q_auto,w_760,h_760/prodmedia/media/catalog/product/2/6/26-03-2018_gosha_rubchinskiyxadidas_copaprimeknitboostmidsneaker_yellow_g012sh12-220_ka_1.jpg"
            }
        ]
    """
    
    private lazy var products: [Product]? = {
        guard let data = productsJson.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode([Product].self, from: data)
    }()
    
    func getProducts(completion: @escaping ((Result<[Product], NetworkError>) -> Void)) {
        if shouldFail {
            completion(.failure(.serverError))
        } else {
            guard let products = products else { return }
            completion(.success(products))
        }
    }
}