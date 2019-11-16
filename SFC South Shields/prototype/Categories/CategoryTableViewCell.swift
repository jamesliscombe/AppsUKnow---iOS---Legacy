//
//  categoryTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 08/07/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundUIView: UIView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
