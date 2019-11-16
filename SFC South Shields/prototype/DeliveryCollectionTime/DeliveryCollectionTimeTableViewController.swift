//
//  DeliveryCollectionTimeTableViewController.swift
//  prototype
//
//  Created by James Liscombe on 16/08/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class DeliveryCollectionTimeTableViewController: UITableViewController, UITextViewDelegate, PayByCashOrCardButtonTableViewCellProtocol, UITextFieldDelegate {
    
    //MARK: - Properties and computed variables
    var delivery = Bool()
    var finalPrice: Double?
    let basket = BasketArrays()
    var note = String()
    var selectedTime: String = "Today ASAP"
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        if !Reachability.isConnectedToNetwork(){
            print("Internet Connection not Available!")
            noInternetConnection()
        }
        
        let selectTimeTableViewCellNib = UINib(nibName: "SelectTimeTableViewCell", bundle: nil)
        tableView.register(selectTimeTableViewCellNib, forCellReuseIdentifier: "SelectTimeTableViewCell")
        
        let noteTableViewCellNib = UINib(nibName: "NoteTableViewCell", bundle: nil)
        tableView.register(noteTableViewCellNib, forCellReuseIdentifier: "NoteTableViewCell")
        
        let payByCashOrCardButtonTableViewCellNib = UINib(nibName: "PayByCashOrCardButtonTableViewCell", bundle: nil)
        tableView.register(payByCashOrCardButtonTableViewCellNib, forCellReuseIdentifier: "PayByCashOrCardButtonTableViewCell")
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "Background"))
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        var currTime = String(hour)+String(minutes)
        
        if(minutes == 0 || minutes == 1 || minutes == 2 || minutes == 3 || minutes == 4 || minutes == 5 || minutes == 6 || minutes == 7 || minutes == 8 || minutes == 9) {
            currTime = String(hour)+"0"+String(minutes)
        }
        
        print(currTime)
        
        
        if(delivery == true) {
            if(Int(currTime) ?? 1720 < Constants.deliveryTimeStart) {
                let alertController = UIAlertController(title: "Please note...", message:
                    "Delivery starts at \(String(Constants.deliveryTimeStart).prefix(2)):\(String(Constants.deliveryTimeStart).suffix(2)). You can place your delivery order in advance or order for collection if you'd like your meal sooner", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - TableView functions (overrides)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            let selectTimeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SelectTimeTableViewCell", for: indexPath) as! SelectTimeTableViewCell
            selectTimeTableViewCell.selectedTimeTextField.delegate = self
            if(delivery == true) {
                selectTimeTableViewCell.deliveryCollectionLabel.text = "Delivery:"
            } else {
                selectTimeTableViewCell.deliveryCollectionLabel.text = "Collection:"
            }
            
            selectTimeTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
            return selectTimeTableViewCell
        } else if(indexPath.row == 1) {
            let noteTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as! NoteTableViewCell
            noteTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
            noteTableViewCell.noteTextView.text = "Enter a note for the takeaway (optional)"
            noteTableViewCell.noteTextView.textColor = UIColor.lightGray
            noteTableViewCell.noteTextView.delegate = self
            return noteTableViewCell
        } else {
            let payByCashOrCardButtonTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PayByCashOrCardButtonTableViewCell", for: indexPath) as! PayByCashOrCardButtonTableViewCell
            payByCashOrCardButtonTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
            payByCashOrCardButtonTableViewCell.delegate = self
            return payByCashOrCardButtonTableViewCell
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showNameAddress") {
            let nameAddressTableViewController = segue.destination as! NameAddressTableViewController
            if(self.delivery == true) {
                nameAddressTableViewController.delivery = true
                nameAddressTableViewController.finalPrice = self.basket.totalPriceOfAllItems() + Double(BasketArrays.deliveryCharge)!
            } else {
                nameAddressTableViewController.delivery = false
                nameAddressTableViewController.finalPrice = self.basket.totalPriceOfAllItems()
            }
            nameAddressTableViewController.deliveryCollectionTime = self.selectedTime
            nameAddressTableViewController.note = self.note
            nameAddressTableViewController.show(self, sender: nil)
        }
    }
    
    //MARK: - Custom functions
    
    //MARK: - Objc functions
    
    //MARK: - Protocols
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        
        if(textView.text.count == 1) {
            self.note = ""
        } else {
            self.note = textView.text + text
        }
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter a note for the takeaway (optional)"
            textView.textColor = UIColor.lightGray
        } else {
            self.note = textView.text
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.selectedTime = textField.text!
    }
    
    func buttonPressed() {
        performSegue(withIdentifier: "showNameAddress", sender: nil)
    }
    
}
