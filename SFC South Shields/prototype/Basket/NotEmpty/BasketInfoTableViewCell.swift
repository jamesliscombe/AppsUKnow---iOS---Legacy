//
//  BasketInfoTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 08/08/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class BasketInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceTotalLabel: UILabel!
    @IBOutlet weak var itemsTotalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
