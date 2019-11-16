//
//  DeliveryCollectionTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 08/08/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

protocol DeliveryCollectionTableViewCellProtocol: class {
    func deliveryCollectionChoice(choice: String)
}

class DeliveryCollectionTableViewCell: UITableViewCell {
    
    var deliverySelected: Bool?
    weak var delegate: DeliveryCollectionTableViewCellProtocol?
    @IBOutlet weak var deliveryButton: UIButton!
    @IBOutlet weak var collectionButton: UIButton!
    @IBOutlet weak var backgroundUIView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundUIView.layer.cornerRadius = 5
        backgroundUIView.layer.masksToBounds = true
        
        deliverySelected = true
        deliveryButton.setBackgroundImage(UIImage(named: "checked"), for: .normal)
        collectionButton.setBackgroundImage(UIImage(named: "unchecked"), for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func deliveryButton(_ sender: UIButton) {
        deliverySelected = true
        deliveryButton.setBackgroundImage(UIImage(named: "checked"), for: .normal)
        collectionButton.setBackgroundImage(UIImage(named: "unchecked"), for: .normal)
        self.delegate?.deliveryCollectionChoice(choice: "delivery")
    }
    
    @IBAction func collectionButton(_ sender: UIButton) {
        deliverySelected = false
        collectionButton.setBackgroundImage(UIImage(named: "checked"), for: .normal)
        deliveryButton.setBackgroundImage(UIImage(named: "unchecked"), for: .normal)
        self.delegate?.deliveryCollectionChoice(choice: "collection")
    }
    
}
