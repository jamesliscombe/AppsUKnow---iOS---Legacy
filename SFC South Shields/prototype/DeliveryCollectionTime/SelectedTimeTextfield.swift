//
//  SelectedTimeTextfield.swift
//  prototype
//
//  Created by James Liscombe on 20/08/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class SelectedTimeTextfield: UITextField {
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(selectAll(_:)) || action == #selector(paste(_:)) {
            return false
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
}
