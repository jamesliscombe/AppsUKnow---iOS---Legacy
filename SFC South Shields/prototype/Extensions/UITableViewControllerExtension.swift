//
//  UITableViewControllerExtension.swift
//  prototype
//
//  Created by James Liscombe on 05/08/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

extension UITableViewController {
    
    func calculateTitleOfBasketButton() -> Bool {
        var title = String()
        let basket = BasketArrays()
        
        if(basket.totalPriceOfAllItems() == 0.0) {
            title = "£0.00"
        } else {
            title = String(format: "£%.02f", basket.totalPriceOfAllItems())
        }
        
        self.addBasketButtonToBarOnRight(title: title)
        return true
    }
    
    func noInternetConnection() {
        let alertController = UIAlertController(title: "Internet Connection Error",
                                                message: "It looks like an internet connection couldn't be established. Please check your cellular or wifi settings.",
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
        })
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
}
