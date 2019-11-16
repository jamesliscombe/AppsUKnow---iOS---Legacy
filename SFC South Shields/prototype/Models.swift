//
//  Models.swift
//  prototype
//
//  Created by James Liscombe on 08/10/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import Foundation

class DeliveryChargeModel: Decodable {
    var ID: Int?
    var setting: String?
    var value: String?
}

class AverageTimesModel: Decodable {
    var ID: Int?
    var setting: String?
    var value: String?
}

class KeysModel: Decodable {
    var ID: Int?
    var stripe_publishable_key: String?
}

class ItemsModel: Decodable {
    var ID: Int?
    var name : String?
    var category: String?
    var description: String?
    var price: String?
    var has_children: String?
}

class MultiItemsModel: Decodable {
    var ID: Int?
    var name: String?
    var description: String?
    var price: String?
    //var related_item_ID: Int?
}

class DealsModel: Decodable {
    var deal_id: Int?
    var name: String?
    var description: String?
    var price: String?
    var num_sections: Int?
}

class CategoryModel: Decodable {
    var ID: Int?
    var name: String?
    var description: String?
}

class ItemDetailModel: Decodable {
    var ID: Int?
    var name: String?
    var description: String?
    var price: String?
}

class MultiItemDetailModel: Decodable {
    var ID: Int?
    var name: String?
    var description: String?
    var price: String?
}

class DealItemsModel: Decodable {
    var deal_item_id: Int?
    var deal_id: Int?
    var section: Int?
    var item: String?
}

class Deals {
    var id: String?
    var name: String?
    var choices: [String]?
    var price: Double?
}
