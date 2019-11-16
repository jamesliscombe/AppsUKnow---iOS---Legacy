//
//  AddToBasketTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 09/10/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

protocol AddToBasketTableViewCellProtocol: class {
    func addToBasket()
}

class AddToBasketTableViewCell: UITableViewCell {
    
    weak var delegate: AddToBasketTableViewCellProtocol!
    
    @IBOutlet weak var goToCheckoutButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func addToBasketButton(_ sender: UIButton) {
        self.delegate.addToBasket()
    }
}
