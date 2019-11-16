//
//  GoToCheckoutButtonTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 06/08/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

protocol GoToCheckoutButtonTableViewCellProtocol: class {
    func goToCheckoutButtonPressed()
}

class GoToCheckoutButtonTableViewCell: UITableViewCell {
    
    weak var delegate: GoToCheckoutButtonTableViewCellProtocol!
    
    @IBOutlet weak var checkoutButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func goToCheckout(_ sender: UIButton) {
        self.delegate.goToCheckoutButtonPressed()
    }
    
}
