//
//  restaurantInfoTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 06/07/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class RestaurantInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var restaurantLogoImage: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantCusineLabel: UILabel!
    @IBOutlet weak var restaurantDeliveryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
