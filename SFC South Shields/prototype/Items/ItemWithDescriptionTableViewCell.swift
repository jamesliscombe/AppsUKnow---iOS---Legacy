//
//  itemTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 12/07/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

protocol AddSingleItemWithDescriptionToBasketButtonProtocol: class {
    func addToBasket(item_id: String, multi:String, price: String)
}

class ItemWithDescriptionTableViewCell: UITableViewCell {
    
    var item_id: String?
    var multi: String?
    weak var delegate: AddSingleItemWithDescriptionToBasketButtonProtocol!
    @IBOutlet weak var addToBasketButton: UIButton!
    @IBOutlet weak var itemFromLabel: UILabel!
    @IBOutlet weak var backgroundUIView: UIView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func addToBasketButton(_ sender: UIButton) {
        if(self.delegate != nil){
            self.delegate.addToBasket(item_id: self.item_id!, multi: self.multi!, price: self.itemPriceLabel.text!)
        }
    }
}
