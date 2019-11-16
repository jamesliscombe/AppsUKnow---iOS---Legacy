//
//  BasketItemTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 10/08/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

protocol BasketItemTableViewCellProtocol: class {
    func updatedAmount()
}

class BasketItemTableViewCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var item_id: String?
    var singleItem: Bool?
    var quantityValues = Array(1...99)
    var selectedQty: Int = 1
    var itemPrice: Double?
    weak var delegate: BasketItemTableViewCellProtocol?
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemQuantityTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createPicker()
        createToolbar()
    }
    
    func createPicker() {
        let qtyPicker = UIPickerView()
        qtyPicker.delegate = self
        itemQuantityTextField.inputView = qtyPicker
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(BasketItemTableViewCell.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        itemQuantityTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func itemQuantityUpdate(_ sender: UITextField) {
        if(singleItem == true) {
            let price = self.itemPrice! * Double(selectedQty)
            BasketArrays.singleItems.updateValue(Int(sender.text!)!, forKey: self.item_id!)
            BasketArrays.totalPriceSingle.updateValue(price, forKey: self.item_id!)
            self.delegate?.updatedAmount()
        } else {
            let price = self.itemPrice! * Double(selectedQty)
            BasketArrays.multiItems.updateValue(Int(sender.text!)!, forKey: self.item_id!)
            BasketArrays.totalPriceMulti.updateValue(price, forKey: self.item_id!)
            self.delegate?.updatedAmount()
        }
    }
    
    //MARK: - Protocols
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.quantityValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(self.quantityValues[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedQty = quantityValues[row]
        itemQuantityTextField.text = String(selectedQty)
    }
    
}
