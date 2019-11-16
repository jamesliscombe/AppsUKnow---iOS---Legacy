//
//  DealBasketTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 11/10/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class DealBasketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dealInfoLabel: UILabel!
    @IBOutlet weak var dealPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
