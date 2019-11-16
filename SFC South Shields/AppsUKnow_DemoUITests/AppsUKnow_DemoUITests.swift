//
//  AppsUKnow_DemoUITests.swift
//  AppsUKnow_DemoUITests
//
//  Created by James Liscombe on 15/01/2019.
//  Copyright © 2019 appsuknow. All rights reserved.
//

import XCTest

class AppsUKnow_DemoUITests: XCTestCase {

    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testPlaceSingleItemOrderWithQuantityOfOneCollection() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["STARTERS"]/*[[".cells.staticTexts[\"STARTERS\"]",".staticTexts[\"STARTERS\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Onion Bhaji (S)")/*[[".cells.containing(.staticText, identifier:\"2.90\")",".cells.containing(.staticText, identifier:\"This is a description for an onion bhaji. It's very long and should go on several lines and cause the cell to expand.\")",".cells.containing(.staticText, identifier:\"Onion Bhaji (S)\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        app.alerts["Success"].buttons["OK"].tap()
        app.navigationBars["STARTERS"].staticTexts["£2.90"].tap()
        
        let uncheckedButton = tablesQuery/*@START_MENU_TOKEN@*/.buttons["unchecked"]/*[[".cells.buttons[\"unchecked\"]",".buttons[\"unchecked\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ //Collection
        uncheckedButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Checkout"]/*[[".cells.buttons[\"Checkout\"]",".buttons[\"Checkout\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Pay Cash/Card"]/*[[".cells.buttons[\"Pay Cash\/Card\"]",".buttons[\"Pay Cash\/Card\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        uncheckedButton.tap()
        let username = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Enter Name"]/*[[".cells.textFields[\"Enter Name\"]",".textFields[\"Enter Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        username.tap()
        username.typeText("James Liscombe UITest")
        
        let enterPhoneNumberTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Enter Phone Number"]/*[[".cells.textFields[\"Enter Phone Number\"]",".textFields[\"Enter Phone Number\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        enterPhoneNumberTextField.tap()
        enterPhoneNumberTextField.tap()
        enterPhoneNumberTextField.typeText("07412533337")
        let email = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Enter Email"]/*[[".cells.textFields[\"Enter Email\"]",".textFields[\"Enter Email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        email.tap()
        email.typeText("jliscombe@me.com")
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Place Order"]/*[[".cells.buttons[\"Place Order\"]",".buttons[\"Place Order\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Order Placed"].buttons["OK"].tap()
    }
    
    func testPlacingLargeOrderWithMultipleQuantitiesForDelivery() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let dealsStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["DEALS"]/*[[".cells.staticTexts[\"DEALS\"]",".staticTexts[\"DEALS\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dealsStaticText.tap()
        tablesQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element(boundBy: 0).tap()
        
        let element = tablesQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element(boundBy: 0)
        element.tap()
        
        let tablesQuery2 = tablesQuery
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["Chicken Madras"]/*[[".cells.staticTexts[\"Chicken Madras\"]",".staticTexts[\"Chicken Madras\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let element2 = tablesQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element(boundBy: 0)
        element2.tap()
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["Onion Pilau"]/*[[".cells.staticTexts[\"Onion Pilau\"]",".staticTexts[\"Onion Pilau\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element(boundBy: 0).tap()
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["Plain Naan"]/*[[".cells.staticTexts[\"Plain Naan\"]",".staticTexts[\"Plain Naan\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let addToBasketButton = tablesQuery2/*@START_MENU_TOKEN@*/.buttons["Add To Basket"]/*[[".cells.buttons[\"Add To Basket\"]",".buttons[\"Add To Basket\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        addToBasketButton.tap()
        
        let okButton = app.alerts["Success"].buttons["OK"]
        okButton.tap()
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["MUNCH BOXES"]/*[[".cells.staticTexts[\"MUNCH BOXES\"]",".staticTexts[\"MUNCH BOXES\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Shake N Spice")/*[[".cells.containing(.staticText, identifier:\"8.95\")",".cells.containing(.staticText, identifier:\"Shake N Spice\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Massalla Sauce Shake N Spice")/*[[".cells.containing(.staticText, identifier:\"Slices of chicken tikka, meatballs, potato skins, onion rings, chips in a stir fry with onions and peppers served with a mint sauce + Massalla sauce\")",".cells.containing(.staticText, identifier:\"Massalla Sauce Shake N Spice\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        okButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Curry Sauce Shake N Spice")/*[[".cells.containing(.staticText, identifier:\"Slices of chicken tikka, meatballs, potato skins, onion rings, chips in a stir fry with onions and peppers served with a mint sauce + Curry sauce\")",".cells.containing(.staticText, identifier:\"Curry Sauce Shake N Spice\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        okButton.tap()
        
        let munchBoxesButton = app.navigationBars["AppsUKnow_Demo.MultiItemsTableView"].buttons["MUNCH BOXES"]
        munchBoxesButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Kebab Kit")/*[[".cells.containing(.staticText, identifier:\"9.95\")",".cells.containing(.staticText, identifier:\"Kebab Kit\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        
        let button = tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Madras Sauce Kebab Kit")/*[[".cells.containing(.staticText, identifier:\"Chicken tikka, sheek kebab, chicken wings, lamb tikka, chips in a stir fry with onions and peppers served with a mint sauce + Madras dipping sauce\")",".cells.containing(.staticText, identifier:\"Madras Sauce Kebab Kit\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element
        button.tap()
        okButton.tap()
        button.tap()
        okButton.tap()
        munchBoxesButton.tap()
        app.navigationBars["MUNCH BOXES"].buttons["Back"].tap()
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["STARTERS"]/*[[".cells.staticTexts[\"STARTERS\"]",".staticTexts[\"STARTERS\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Onion Bhaji (S)")/*[[".cells.containing(.staticText, identifier:\"2.90\")",".cells.containing(.staticText, identifier:\"This is a description for an onion bhaji. It's very long and should go on several lines and cause the cell to expand.\")",".cells.containing(.staticText, identifier:\"Onion Bhaji (S)\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        okButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Mixed Kebab (S)")/*[[".cells.containing(.staticText, identifier:\"3.20\")",".cells.containing(.staticText, identifier:\"Mixed Kebab (S)\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        okButton.tap()
        app.navigationBars["STARTERS"].buttons["Back"].tap()
        dealsStaticText.tap()
        element.tap()
        element.tap()
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["sdfklsd;flk"]/*[[".cells.staticTexts[\"sdfklsd;flk\"]",".staticTexts[\"sdfklsd;flk\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        element2.tap()
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["sdffsdf"]/*[[".cells.staticTexts[\"sdffsdf\"]",".staticTexts[\"sdffsdf\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        addToBasketButton.tap()
        okButton.tap()
        app.navigationBars["AppsUKnow_Demo.CategoriesTableView"].staticTexts["£78.90"].tap()
        tablesQuery2/*@START_MENU_TOKEN@*/.buttons["Checkout"]/*[[".cells.buttons[\"Checkout\"]",".buttons[\"Checkout\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery2/*@START_MENU_TOKEN@*/.buttons["Pay Cash/Card"]/*[[".cells.buttons[\"Pay Cash\/Card\"]",".buttons[\"Pay Cash\/Card\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let name = tablesQuery2/*@START_MENU_TOKEN@*/.textFields["Enter Name"]/*[[".cells.textFields[\"Enter Name\"]",".textFields[\"Enter Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        name.tap()
        name.typeText("James Liscombe UITest")
        let phone = tablesQuery2/*@START_MENU_TOKEN@*/.textFields["Enter Phone Number"]/*[[".cells.textFields[\"Enter Phone Number\"]",".textFields[\"Enter Phone Number\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        phone.tap()
        phone.typeText("07412533337")
        
        let enterEmailTextField = tablesQuery2/*@START_MENU_TOKEN@*/.textFields["Enter Email"]/*[[".cells.textFields[\"Enter Email\"]",".textFields[\"Enter Email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        enterEmailTextField.tap()
        enterEmailTextField.tap()
        enterEmailTextField.typeText("jliscombe@me.com")
        
        let enterAddressTextField = tablesQuery2/*@START_MENU_TOKEN@*/.textFields["Enter Address"]/*[[".cells.textFields[\"Enter Address\"]",".textFields[\"Enter Address\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        enterAddressTextField.tap()
        enterAddressTextField.tap()
        enterAddressTextField.typeText("13 Walworth Avenue")
        
        let enterCityTextField = tablesQuery2/*@START_MENU_TOKEN@*/.textFields["Enter City"]/*[[".cells.textFields[\"Enter City\"]",".textFields[\"Enter City\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        enterCityTextField.tap()
        enterCityTextField.tap()
        enterCityTextField.typeText("South Shields")
        
        let enterPostcodeTextField = tablesQuery2/*@START_MENU_TOKEN@*/.textFields["Enter Postcode"]/*[[".cells.textFields[\"Enter Postcode\"]",".textFields[\"Enter Postcode\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        enterPostcodeTextField.tap()
        enterPostcodeTextField.tap()
        enterPostcodeTextField.typeText("NE347EP")
        tablesQuery2/*@START_MENU_TOKEN@*/.buttons["Place Order"]/*[[".cells.buttons[\"Place Order\"]",".buttons[\"Place Order\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let cardNum = tablesQuery2/*@START_MENU_TOKEN@*/.textFields["4242424242424242"]/*[[".cells.textFields[\"4242424242424242\"]",".textFields[\"4242424242424242\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cardNum.tap()
        cardNum.typeText("5555555555554444")
        let expDate = tablesQuery2/*@START_MENU_TOKEN@*/.textFields["MM/YY"]/*[[".cells.textFields[\"MM\/YY\"]",".textFields[\"MM\/YY\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        expDate.tap()
        expDate.typeText("0121")
        let cvc = tablesQuery2/*@START_MENU_TOKEN@*/.textFields["CVC"]/*[[".cells.textFields[\"CVC\"]",".textFields[\"CVC\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cvc.tap()
        cvc.typeText("123")
        app.navigationBars["Add a Card"].buttons["Done"].tap()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(7), execute: {
            app.alerts["Order Placed"].buttons["OK"].tap()
        })
        
    }
    
    func testRemovalOfAllItemsInBasket() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["STARTERS"]/*[[".cells.staticTexts[\"STARTERS\"]",".staticTexts[\"STARTERS\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Onion Bhaji (S)")/*[[".cells.containing(.staticText, identifier:\"2.90\")",".cells.containing(.staticText, identifier:\"This is a description for an onion bhaji. It's very long and should go on several lines and cause the cell to expand.\")",".cells.containing(.staticText, identifier:\"Onion Bhaji (S)\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        
        let okButton = app.alerts["Success"].buttons["OK"]
        okButton.tap()
        tablesQuery.cells.containing(.staticText, identifier:"Samosa").children(matching: .button).element.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Mixed Samosa")/*[[".cells.containing(.staticText, identifier:\"4.00\")",".cells.containing(.staticText, identifier:\"Mixed Samosa\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        okButton.tap()
        app.navigationBars["AppsUKnow_Demo.MultiItemsTableView"].buttons["STARTERS"].tap()
        app.navigationBars["STARTERS"].buttons["Back"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["DEALS"]/*[[".cells.staticTexts[\"DEALS\"]",".staticTexts[\"DEALS\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["A deal for one, select any curry and any rice with a Naan bread"]/*[[".cells.staticTexts[\"A deal for one, select any curry and any rice with a Naan bread\"]",".staticTexts[\"A deal for one, select any curry and any rice with a Naan bread\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Choice 1"]/*[[".cells.staticTexts[\"Choice 1\"]",".staticTexts[\"Choice 1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Chicken Madras"]/*[[".cells.staticTexts[\"Chicken Madras\"]",".staticTexts[\"Chicken Madras\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Choice 2"]/*[[".cells.staticTexts[\"Choice 2\"]",".staticTexts[\"Choice 2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Onion Pilau"]/*[[".cells.staticTexts[\"Onion Pilau\"]",".staticTexts[\"Onion Pilau\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Choice 3"]/*[[".cells.staticTexts[\"Choice 3\"]",".staticTexts[\"Choice 3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Cheese Naan"]/*[[".cells.staticTexts[\"Cheese Naan\"]",".staticTexts[\"Cheese Naan\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Add To Basket"]/*[[".cells.buttons[\"Add To Basket\"]",".buttons[\"Add To Basket\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        okButton.tap()
        app.navigationBars["AppsUKnow_Demo.CategoriesTableView"].staticTexts["£21.90"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Deal For One\n\nChicken Madras\nOnion Pilau\nCheese Naan"]/*[[".cells[\"Deal For One\\n\\nChicken Madras\\nOnion Pilau\\nCheese Naan, £15.00\"].staticTexts[\"Deal For One\\n\\nChicken Madras\\nOnion Pilau\\nCheese Naan\"]",".staticTexts[\"Deal For One\\n\\nChicken Madras\\nOnion Pilau\\nCheese Naan\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
        
        let deleteButton = tablesQuery.buttons["Delete"]
        deleteButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["£4.00"]/*[[".cells.staticTexts[\"£4.00\"]",".staticTexts[\"£4.00\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
        deleteButton.tap()
        tablesQuery.cells.containing(.staticText, identifier:"Onion Bhaji (S)").staticTexts["£2.90"].swipeLeft()
        deleteButton.tap()
        
    }

}
