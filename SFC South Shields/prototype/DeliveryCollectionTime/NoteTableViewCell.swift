//
//  NoteTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 20/08/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noteTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
