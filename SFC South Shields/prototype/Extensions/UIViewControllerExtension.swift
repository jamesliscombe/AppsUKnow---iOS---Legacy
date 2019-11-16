//
//  UIViewControllerExtension.swift
//  prototype
//
//  Created by James Liscombe on 03/08/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addBasketButtonToBarOnRight(title: String) {
        let imageView = UIImageView(frame: CGRect(x: 8, y: 3, width: 22, height: 22))
        imageView.backgroundColor = UIColor(red:0.20, green:0.40, blue:0.71, alpha:1.0)
        imageView.layer.cornerRadius = 2
        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 102, height: 30))
        buttonView.backgroundColor = UIColor(red:0.20, green:0.40, blue:0.71, alpha:1.0)
        buttonView.layer.cornerRadius = 2
        let label = UILabel(frame: CGRect(x: 35, y: 0, width: 80, height: 30))
        let rightBarButtonItem = UIButton.init(type: .custom)
        let barButton = UIBarButtonItem.init(customView: buttonView)
        
        rightBarButtonItem.setTitleColor(.white, for: .normal)
        rightBarButtonItem.backgroundColor = UIColor(red:0.20, green:0.40, blue:0.71, alpha:1.0)
        rightBarButtonItem.layer.cornerRadius = 2
        rightBarButtonItem.addTarget(self, action: #selector(segueToBasket(_:)), for: .touchUpInside)
        rightBarButtonItem.frame = buttonView.frame
        
        imageView.image = UIImage(named: "shopping-basket")
        label.text = title
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .body)
        buttonView.addSubview(rightBarButtonItem)
        buttonView.addSubview(imageView)
        buttonView.addSubview(label)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func segueToBasket(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showBasket", sender: nil)
    }
    
    func setNavBarColour() {
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor(red:0.86, green:0.87, blue:0.89, alpha:1.0)
        navBar?.tintColor = UIColor.black
    }
}
