//
//  BasketArrays.swift
//  prototype
//
//  Created by James Liscombe on 05/08/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import Foundation

class BasketArrays {
    static var singleItems : Dictionary = [String:Int]() //ItemID:Quantity
    static var multiItems : Dictionary = [String:Int]() //ItemID:Quantity
    static var totalPriceSingle : Dictionary = [String:Double]()//ItemID:Price (updates depending on quantity)
    static var totalPriceMulti : Dictionary = [String:Double]()//ItemID:Price (updates depending on quantity)
    
    //Deal logic
    //static var dealQuantity = Int()
    static var deals = [Deals]()
    
    //Delivery logic
    static var minOrder = String()
    static var deliveryCharge = String()
    
    func roundToPlaces(value:Double, places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(value * divisor) / divisor
    }
    
    func totalPriceOfAllItems() -> Double {
        var price = 0.0
        
        if(BasketArrays.deals.isEmpty) {
            price += 0.0
        } else {
            for (deal) in BasketArrays.deals {
                price += deal.price!
            }
        }
        
        if(BasketArrays.totalPriceSingle.isEmpty) {
            price += 0.0
        } else {
            for (_, value) in BasketArrays.totalPriceSingle {
                price += value
            }
        }
        
        if(BasketArrays.totalPriceMulti.isEmpty) {
            price += 0.0
        } else {
            for (_, value) in BasketArrays.totalPriceMulti {
                price += value
            }
        }
        
        return roundToPlaces(value: price, places: 2)
    }
    
    
    func countOfItems() -> Int {
        var items = 0
        
        if(BasketArrays.singleItems.isEmpty) {
            items += 0
        } else {
            for (_, value) in BasketArrays.singleItems {
                items += value
            }
        }
        
        if(BasketArrays.multiItems.isEmpty) {
            items += 0
        } else {
            for (_, value) in BasketArrays.multiItems {
                items += value
            }
        }
        
        items += BasketArrays.deals.count
        
        return items
    }
}


