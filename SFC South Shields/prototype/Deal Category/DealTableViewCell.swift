//
//  DealTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 07/10/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class DealTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dealNameLabel: UILabel!
    @IBOutlet weak var dealPriceLabel: UILabel!
    @IBOutlet weak var backgroundUIView: UIView!
    @IBOutlet weak var dealDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
