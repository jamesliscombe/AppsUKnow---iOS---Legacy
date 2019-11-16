//
//  PaymentMethodTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 20/09/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

protocol PaymentMethodTableViewCellProtocol: class {
    func cardCashChoice(choice: String)
}

class PaymentMethodTableViewCell: UITableViewCell {
    
    var cardSelected: Bool?
    weak var delegate: PaymentMethodTableViewCellProtocol!
    @IBOutlet weak var cardButton: UIButton!
    @IBOutlet weak var cashButton: UIButton!
    @IBOutlet weak var backgroundUIView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundUIView.layer.cornerRadius = 5
        backgroundUIView.layer.masksToBounds = true
        
        cardSelected = true
        
        cardButton.setBackgroundImage(UIImage(named: "checked"), for: .normal)
        cashButton.setBackgroundImage(UIImage(named: "unchecked"), for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func cardButton(_ sender: UIButton) {
        cardSelected = true
        cardButton.setBackgroundImage(UIImage(named: "checked"), for: .normal)
        cashButton.setBackgroundImage(UIImage(named: "unchecked"), for: .normal)
        self.delegate?.cardCashChoice(choice: "card")
    }
    
    @IBAction func cashButton(_ sender: UIButton) {
        cardSelected = false
        cashButton.setBackgroundImage(UIImage(named: "checked"), for: .normal)
        cardButton.setBackgroundImage(UIImage(named: "unchecked"), for: .normal)
        self.delegate?.cardCashChoice(choice: "cash")
    }
    
}
