//
//  UITableViewControllerExtensionTests.swift
//  AppsUKnow_DemoTests
//
//  Created by James Liscombe on 14/01/2019.
//  Copyright © 2019 appsuknow. All rights reserved.
//

import XCTest
@testable import AppsUKnow_Demo

class UITableViewControllerExtensionTests: XCTestCase {
    
    var categoriesTableViewController: CategoriesTableViewController?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        categoriesTableViewController = CategoriesTableViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCalculateBasketButtonTitle() {
        XCTAssertTrue((categoriesTableViewController?.calculateTitleOfBasketButton())!)
    }

}
