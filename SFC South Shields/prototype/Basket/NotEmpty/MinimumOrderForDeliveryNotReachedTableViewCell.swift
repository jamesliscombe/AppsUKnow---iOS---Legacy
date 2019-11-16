//
//  MinimumOrderForDeliveryNotReachedTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 09/08/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class MinimumOrderForDeliveryNotReachedTableViewCell: UITableViewCell {
    
    var minAmountHit: Bool? {
        didSet {
            self.awakeFromNib()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if(minAmountHit == true) {
            self.isHidden = true
        } else {
            self.isHidden = false
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
