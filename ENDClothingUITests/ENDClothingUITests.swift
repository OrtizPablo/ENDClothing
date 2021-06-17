//
//  ENDClothingUITests.swift
//  ENDClothingUITests
//
//  Created by Pablo Ortiz on 08/06/2021.
//

import XCTest

class ENDClothingUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }

    func testHappyFlow() {
        XCTAssertTrue(app.navigationBars.staticTexts["Products"].exists)
        let collection = app.collectionViews["CatalogCollectionView"]
        XCTAssertTrue(collection.exists)
        
        let cell1 = collection.cells["CatalogViewCell0"]
        testCollectionViewCell(cell: cell1, title: "Test Shirt", subtitle: "Yellow", price: "£199")
        cell1.tap()
        testProductDetailScreen()
        
        app.navigationBars.buttons.element(boundBy: 0).tap() // Press back
        
        let cell2 = collection.cells["CatalogViewCell1"]
        testCollectionViewCell(cell: cell2, title: "Test Shirt", subtitle: "Yellow", price: "£199")
        cell2.tap()
        testProductDetailScreen()
    }
    
    private func testCollectionViewCell(cell: XCUIElement, title: String, subtitle: String, price: String) {
        XCTAssertTrue(cell.exists)
        XCTAssertTrue(cell.staticTexts[title].exists)
        XCTAssertTrue(cell.staticTexts[subtitle].exists)
        XCTAssertTrue(cell.staticTexts[price].exists)
    }
    
    private func testProductDetailScreen() {
        let table = app.tables["ProductTableView"]
        XCTAssertTrue(table.exists)
        
        // TODO: add testing to Product detail screen
    }
}
