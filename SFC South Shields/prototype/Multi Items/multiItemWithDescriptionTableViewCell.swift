//
//  multiItemTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 18/07/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

protocol AddMultiItemWithDescriptionToBasketButtonProtocol: class {
    func addToBasket(item_id: String, price: String)
}

class multiItemWithDescriptionTableViewCell: UITableViewCell {
    
    var item_id: String?
    weak var delegate: AddMultiItemWithDescriptionToBasketButtonProtocol!
    @IBOutlet weak var backgroundUIView: UIView!
    @IBOutlet weak var multiItemNameLabel: UILabel!
    @IBOutlet weak var multiItemDescriptionLabel: UILabel!
    @IBOutlet weak var multiItemPriceLabel: UILabel!
    @IBOutlet weak var addToBasketButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func addToBasketButton(_ sender: UIButton) {
        self.delegate.addToBasket(item_id: self.item_id!, price: self.multiItemPriceLabel.text!)
    }
}
