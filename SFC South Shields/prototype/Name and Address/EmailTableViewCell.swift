//
//  EmailTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 17/12/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class EmailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
