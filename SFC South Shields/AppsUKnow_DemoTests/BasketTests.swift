//
//  BasketTests.swift
//  AppsUKnow_DemoTests
//
//  Created by James Liscombe on 14/01/2019.
//  Copyright © 2019 appsuknow. All rights reserved.
//

import XCTest
@testable import AppsUKnow_Demo

class BasketTests: XCTestCase {
    
    var basketArrays: BasketArrays?

    override func setUp() {
        basketArrays = BasketArrays()
        
        BasketArrays.singleItems.updateValue(2, forKey: "Item 1")
        BasketArrays.singleItems.updateValue(35, forKey: "Item 2")
        BasketArrays.singleItems.updateValue(97, forKey: "Item 3")
        BasketArrays.multiItems.updateValue(2, forKey: "Item 1")
        BasketArrays.multiItems.updateValue(5, forKey: "Item 2")
        BasketArrays.multiItems.updateValue(9, forKey: "Item 3")
        
        BasketArrays.totalPriceSingle.updateValue(10.00, forKey: "Item 1")
        BasketArrays.totalPriceSingle.updateValue(1.29, forKey: "Item 2")
        BasketArrays.totalPriceSingle.updateValue(0.79, forKey: "Item 3")
        BasketArrays.totalPriceMulti.updateValue(3, forKey: "Item 1")
        BasketArrays.totalPriceMulti.updateValue(8, forKey: "Item 2")
        BasketArrays.totalPriceMulti.updateValue(13.7, forKey: "Item 3")
        
        let deal1 = Deals()
        deal1.id = "001"
        deal1.name = "Test Deal 1"
        deal1.price = 10.00
        deal1.choices = ["Choice 1","Choice 2","Choice 3"]
        BasketArrays.deals.append(deal1)

        let deal2 = Deals()
        deal2.id = "002"
        deal2.name = "Test Deal 2"
        deal2.price = 99.99
        deal2.choices = ["Choice 1","Choice 2","Choice 3"]
        BasketArrays.deals.append(deal2)
        
        //Total of 152 items
        //Total price of 146.77
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        basketArrays = nil
        BasketArrays.deals.removeAll()
        BasketArrays.singleItems.removeAll()
        BasketArrays.multiItems.removeAll()
        BasketArrays.totalPriceMulti.removeAll()
        BasketArrays.totalPriceSingle.removeAll()
    }
    
    func testCountOfItems() {
        XCTAssertEqual(basketArrays?.countOfItems(),152)
    }
    
    func testPriceOfAllItems() {
        XCTAssertEqual(basketArrays?.totalPriceOfAllItems(), 146.77)
    }

}
