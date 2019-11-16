//
//  CollectionOrderSummaryTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 15/08/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class CollectionOrderSummaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
