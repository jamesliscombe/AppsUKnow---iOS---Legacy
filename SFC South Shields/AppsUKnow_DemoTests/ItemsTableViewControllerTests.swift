//
//  ItemsTableViewControllerTests.swift
//  AppsUKnow_DemoTests
//
//  Created by James Liscombe on 14/01/2019.
//  Copyright © 2019 appsuknow. All rights reserved.
//

import XCTest
@testable import AppsUKnow_Demo

class ItemsTableViewControllerTests: XCTestCase {
    
    var itemsTableViewController: ItemsTableViewController?
    var multiItemsTableViewController: MultiItemsTableViewController?
    var selectedCategory: String?
    var storyboard: UIStoryboard?
    var showMultiItems: UIStoryboardSegue?

    override func setUp() {
        super.setUp()
        itemsTableViewController = ItemsTableViewController()
        multiItemsTableViewController = MultiItemsTableViewController()
        itemsTableViewController?.viewDidLoad()
        selectedCategory = "STARTERS"
        storyboard = UIStoryboard(name: "Main", bundle: nil);
        showMultiItems = UIStoryboardSegue.init(identifier: "showMultiItems", source: itemsTableViewController!, destination: multiItemsTableViewController!)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadItemsFromApi() {
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Checking Delivery Charges API is valid")
        
        // Create a URL for a web page to be downloaded.
        let url = URL(string: "https://demo-api.appsuknow.com/category/items/"+selectedCategory!)!
        
        // Create a background task to download the web page.
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            // Make sure we downloaded some data.
            XCTAssertNotNil(data, "No data was downloaded.")
            
            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
            
        }
        
        // Start the download task.
        dataTask.resume()
        
        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
        
    }
    
//    func testAddItemToBasket() {
//        XCTAssert(((itemsTableViewController?.addToBasket(item_id: "001", multi: "1", price: "3.90")) != nil) == true)
//    }
    
    func testAddSingleItemToBasket() {
        XCTAssertFalse(itemsTableViewController?.addSingleItemOrGoToMultiVC(item_id: "001", multi: "0", price: "5.00") ?? true)
    }

}
