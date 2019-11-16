//
//  PayByCashOrCardButtonTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 20/08/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

protocol PayByCashOrCardButtonTableViewCellProtocol: class {
    func buttonPressed()
}

class PayByCashOrCardButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var payCashCardButton: UIButton!
    
    weak var delegate: PayByCashOrCardButtonTableViewCellProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        self.delegate.buttonPressed()
    }
}
