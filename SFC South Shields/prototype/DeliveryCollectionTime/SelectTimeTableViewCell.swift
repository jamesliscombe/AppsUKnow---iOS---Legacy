//
//  SelectTimeTableViewCell.swift
//  prototype
//
//  Created by James Liscombe on 16/08/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class SelectTimeTableViewCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var lastTime: Double = 23.30
    var startTimeToday : Double = 17
    var startTimeTomorrow : Double = 17
    var slotIncrement = 0.5
    var timeSlots = [String]()
    var incrementMinutes: Double = 30
    let date = Date()
    let calendar = Calendar.current
    
    
    @IBOutlet weak var selectedTimeTextField: SelectedTimeTextfield!
    @IBOutlet weak var deliveryCollectionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let hour = calendar.component(.hour, from: date)
        
        if(Double(hour) > startTimeToday) {
            startTimeToday = Double(hour)
        }
        
        timeSlots.append("Today ASAP")
        
        while (startTimeToday <= lastTime) {
            startTimeToday += (incrementMinutes/60)
            let hours = Int(floor(startTimeToday))
            let minutes = Int(startTimeToday.truncatingRemainder(dividingBy: 1)*60)
            if (minutes == 0) {
                timeSlots.append("Today at \(hours):00")
            } else {
                timeSlots.append("Today at \(hours):\(minutes)")
            }
        }
        
        while (startTimeTomorrow <= lastTime) {
            startTimeTomorrow += (incrementMinutes/60)
            let hours = Int(floor(startTimeTomorrow))
            let minutes = Int(startTimeTomorrow.truncatingRemainder(dividingBy: 1)*60)
            if (minutes == 0) {
                timeSlots.append("Tomorrow at \(hours):00")
            } else {
                timeSlots.append("Tomorrow at \(hours):\(minutes)")
            }
        }
        createPicker()
        createToolbar()
    }
    
    func createPicker() {
        let qtyPicker = UIPickerView()
        qtyPicker.delegate = self
        selectedTimeTextField.inputView = qtyPicker
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(BasketItemTableViewCell.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        selectedTimeTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
    //MARK: - Protocols
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.timeSlots.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(self.timeSlots[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTimeTextField.text = String(timeSlots[row])
    }
}
