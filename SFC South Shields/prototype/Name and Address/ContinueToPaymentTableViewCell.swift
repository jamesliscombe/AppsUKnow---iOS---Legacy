//
//  ContinueToPaymentTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 11/09/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

protocol ContinueToPaymentTableViewCellProtocol: class {
    func proceedToPayment()
}

class ContinueToPaymentTableViewCell: UITableViewCell {
    
    weak var delegate: ContinueToPaymentTableViewCellProtocol!
    @IBOutlet weak var placeOrderButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func continueToPayment(_ sender: UIButton) {
        self.delegate.proceedToPayment()
    }
}
