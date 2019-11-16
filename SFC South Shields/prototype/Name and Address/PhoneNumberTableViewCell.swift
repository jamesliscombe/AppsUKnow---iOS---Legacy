//
//  PhoneNumberTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 22/08/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class PhoneNumberTableViewCell: UITableViewCell {
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
