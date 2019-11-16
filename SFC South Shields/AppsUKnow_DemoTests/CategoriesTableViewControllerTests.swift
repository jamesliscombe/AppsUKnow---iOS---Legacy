//
//  CategoriesTableViewControllerTests.swift
//  AppsUKnow_DemoTests
//
//  Created by James Liscombe on 14/01/2019.
//  Copyright © 2019 appsuknow. All rights reserved.
//

import XCTest
@testable import AppsUKnow_Demo

class CategoriesTableViewControllerTests: XCTestCase {
    
    var categoriesTableView : CategoriesTableViewController?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        categoriesTableView = CategoriesTableViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDownloadedCategoriesFromApi() {
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Checking Categories API is valid")
        
        // Create a URL for a web page to be downloaded.
        let url = URL(string: "https://demo-api.appsuknow.com/category")!
        
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
    
    func testDeliveryChargesFromApi() {
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Checking Delivery Charges API is valid")
        
        // Create a URL for a web page to be downloaded.
        let url = URL(string: "https://demo-api.appsuknow.com/delivery")!
        
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
    
    func testKeysFromApi() {
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Checking Keys API is valid")
        
        // Create a URL for a web page to be downloaded.
        let url = URL(string: "https://demo-api.appsuknow.com/keys")!
        
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
    
    func testAverageTimesFromApi() {
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Checking Keys API is valid")
        
        // Create a URL for a web page to be downloaded.
        let url = URL(string: "https://demo-api.appsuknow.com/times")!
        
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
    
    func testInternetConnection() {
        XCTAssertTrue(Reachability.isConnectedToNetwork())
    }
}
