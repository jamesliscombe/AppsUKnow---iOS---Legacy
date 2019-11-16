
//
//  NameAddressTableViewController.swift
//  prototype
//
//  Created by James Liscombe on 20/08/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit
import Stripe
import Alamofire

class NameAddressTableViewController: UITableViewController, ContinueToPaymentTableViewCellProtocol, UITextFieldDelegate, PaymentMethodTableViewCellProtocol {
    
    //MARK: - Properties and computed variables
    var postcodeCount = 0
    var delivery = Bool()
    var note = String()
    var deliveryCollectionTime = String()
    var finalPrice = Double()
    var name = String()
    var phoneNumber = String()
    var street = String()
    var city = String()
    var email = String()
    var postcode = String()
    var continueToPaymentButton : UIButton?
    
    var card = true {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        if !Reachability.isConnectedToNetwork(){
            print("Internet Connection not Available!")
            noInternetConnection()
        }
        
        let paymentMethodTableViewCellNib = UINib(nibName: "PaymentMethodTableViewCell", bundle: nil)
        tableView.register(paymentMethodTableViewCellNib, forCellReuseIdentifier: "PaymentMethodTableViewCell")
        
        let nameTableViewCellNib = UINib(nibName: "NameTableViewCell", bundle: nil)
        tableView.register(nameTableViewCellNib, forCellReuseIdentifier: "NameTableViewCell")
        
        let phoneNumberTableViewCellNib = UINib(nibName: "PhoneNumberTableViewCell", bundle: nil)
        tableView.register(phoneNumberTableViewCellNib, forCellReuseIdentifier: "PhoneNumberTableViewCell")
        
        let streetTableViewCellNib = UINib(nibName: "StreetTableViewCell", bundle: nil)
        tableView.register(streetTableViewCellNib, forCellReuseIdentifier: "StreetTableViewCell")
        
        let cityTableViewCellNib = UINib(nibName: "CityTableViewCell", bundle: nil)
        tableView.register(cityTableViewCellNib, forCellReuseIdentifier: "CityTableViewCell")
        
        let emailTableViewCellNib = UINib(nibName: "EmailTableViewCell", bundle: nil)
        tableView.register(emailTableViewCellNib, forCellReuseIdentifier: "EmailTableViewCell")
        
        let postcodeTableViewCellNib = UINib(nibName: "PostcodeTableViewCell", bundle: nil)
        tableView.register(postcodeTableViewCellNib, forCellReuseIdentifier: "PostcodeTableViewCell")
        
        let continueToPaymentTableViewCellNib = UINib(nibName: "ContinueToPaymentTableViewCell", bundle: nil)
        tableView.register(continueToPaymentTableViewCellNib, forCellReuseIdentifier: "ContinueToPaymentTableViewCell")
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "Background"))
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - TableView functions (overrides)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0) {
            return 1
        } else {
            if(self.delivery == true) {
                return 7
            } else {
                return 4
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0) {
            let paymentMethodTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodTableViewCell", for: indexPath) as! PaymentMethodTableViewCell
            paymentMethodTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
            paymentMethodTableViewCell.delegate = self
            return paymentMethodTableViewCell
        } else {
            if(self.delivery == false) {
                if (indexPath.row == 0) {
                    let nameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell", for: indexPath) as! NameTableViewCell
                    nameTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                    nameTableViewCell.nameTextField.delegate = self
                    return nameTableViewCell
                } else if (indexPath.row == 1) {
                    let phoneNumberTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PhoneNumberTableViewCell", for: indexPath) as! PhoneNumberTableViewCell
                    phoneNumberTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                    phoneNumberTableViewCell.phoneNumberTextField.delegate = self
                    return phoneNumberTableViewCell
                } else if (indexPath.row == 2) {
                    let emailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmailTableViewCell", for: indexPath) as! EmailTableViewCell
                    emailTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                    emailTableViewCell.emailTextField.delegate = self
                    return emailTableViewCell
                } else {
                    let continueToPaymentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContinueToPaymentTableViewCell", for: indexPath) as! ContinueToPaymentTableViewCell
                    continueToPaymentTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                    continueToPaymentTableViewCell.delegate = self
                    continueToPaymentButton = continueToPaymentTableViewCell.placeOrderButton
                    return continueToPaymentTableViewCell
                }
            } else {
                if (indexPath.row == 0) {
                    let nameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell", for: indexPath) as! NameTableViewCell
                    nameTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                    nameTableViewCell.nameTextField.delegate = self
                    return nameTableViewCell
                } else if (indexPath.row == 1) {
                    let phoneNumberTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PhoneNumberTableViewCell", for: indexPath) as! PhoneNumberTableViewCell
                    phoneNumberTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                    phoneNumberTableViewCell.phoneNumberTextField.delegate = self
                    return phoneNumberTableViewCell
                } else if (indexPath.row == 2) {
                    let emailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmailTableViewCell", for: indexPath) as! EmailTableViewCell
                    emailTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                    emailTableViewCell.emailTextField.delegate = self
                    return emailTableViewCell
                } else if (indexPath.row == 3) {
                    let streetTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StreetTableViewCell", for: indexPath) as! StreetTableViewCell
                    streetTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                    streetTableViewCell.streetTextField.delegate = self
                    return streetTableViewCell
                } else if (indexPath.row == 4) {
                    let cityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as! CityTableViewCell
                    cityTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                    cityTableViewCell.cityTextField.delegate = self
                    return cityTableViewCell
                } else if (indexPath.row == 5) {
                    let postcodeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PostcodeTableViewCell", for: indexPath) as! PostcodeTableViewCell
                    postcodeTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                    postcodeTableViewCell.postcodeTextField.delegate = self
                    if(self.postcodeCount == 0) {
                        postcodeTableViewCell.postcodeTextField.text = ""
                    }
                    return postcodeTableViewCell
                } else {
                    let continueToPaymentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContinueToPaymentTableViewCell", for: indexPath) as! ContinueToPaymentTableViewCell
                    continueToPaymentTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                    continueToPaymentTableViewCell.delegate = self
                    continueToPaymentButton = continueToPaymentTableViewCell.placeOrderButton
                    return continueToPaymentTableViewCell
                }
            }
        }
    }
    
    //MARK: - Custom functions
    func searchPostcode(completion: @escaping (_ success: Bool) -> Void) {
        let postcode = self.postcode.replacingOccurrences(of: " ", with: "")
        
        Alamofire.request(Constants.baseURLString+"postcode/"+postcode.dropLast(3)).responseJSON { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                self.postcodeCount = Int(utf8Text) ?? 0
            }
            
            completion(true)
        }
    }
    
    //MARK: - Objc functions
    
    //MARK: - Protocols
    func cardCashChoice(choice: String) {
        print(choice)
        if(choice == "card") {
            self.card = true
        } else {
            self.card = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.restorationIdentifier == "name") {
            self.name = textField.text!
        }
        
        if(textField.restorationIdentifier == "phoneNumber") {
            self.phoneNumber = textField.text!
        }
        
        if(textField.restorationIdentifier == "email") {
            self.email = textField.text!
        }
        
        if(textField.restorationIdentifier == "street") {
            self.street = textField.text!
        }
        
        if(textField.restorationIdentifier == "city") {
            self.city = textField.text!
        }
        
        if(textField.restorationIdentifier == "postcode") {
            self.postcode = textField.text!
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(string == "\n") {
            textField.resignFirstResponder()
            return false
        }
        
        if(textField.text?.count == 1) {
            if(textField.restorationIdentifier == "name") {
                self.name = ""
            } else if(textField.restorationIdentifier == "phoneNumber") {
                self.phoneNumber = ""
            } else if(textField.restorationIdentifier == "email") {
                self.email = ""
            } else if(textField.restorationIdentifier == "steet") {
                self.street = ""
            } else if(textField.restorationIdentifier == "city") {
                self.city = ""
            } else if(textField.restorationIdentifier == "postcode") {
                self.postcode = ""
            }
        } else {
            if(textField.restorationIdentifier == "name") {
                self.name = textField.text! + string
            } else if(textField.restorationIdentifier == "phoneNumber") {
                self.phoneNumber = textField.text! + string
            } else if(textField.restorationIdentifier == "email") {
                self.email = textField.text! + string
            } else if(textField.restorationIdentifier == "steet") {
                self.street = textField.text! + string
            } else if(textField.restorationIdentifier == "city") {
                self.city = textField.text! + string
            } else if(textField.restorationIdentifier == "postcode") {
                self.postcode = textField.text! + string
            }
        }
        return true
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest  = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func proceedToPayment() {
        continueToPaymentButton?.isEnabled = false
        continueToPaymentButton?.alpha = 0.5
        
        if(!isValidEmail(email: email.trimmingCharacters(in: .whitespacesAndNewlines))) {
            let alert = UIAlertController(title: "Error", message: "Please enter a valid email address", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in}))
            self.present(alert, animated: true, completion: nil)
            self.continueToPaymentButton?.isEnabled = true
            self.continueToPaymentButton?.alpha = 1.0
        } else {
            searchPostcode { (success) -> Void in
                if success {
                    if(self.delivery == true) {
                        if(self.name.isEmpty || self.city.isEmpty || self.phoneNumber.isEmpty || self.postcode.isEmpty || self.street.isEmpty || self.email.isEmpty) {
                            let alert = UIAlertController(title: "Error", message: "Please enter all delivery information", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in}))
                            self.present(alert, animated: true, completion: nil)
                            self.continueToPaymentButton?.isEnabled = true
                            self.continueToPaymentButton?.alpha = 1.0
                        } else {
                            if(self.postcodeCount == 1) {
                                if(self.card == true) {
                                    
                                    let paymentConfig = STPPaymentConfiguration.init()
                                    paymentConfig.publishableKey = Constants.publishableKey!
                                    paymentConfig.requiredBillingAddressFields = STPBillingAddressFields.full
                                    let theme = STPTheme.default()
                                    let addCardViewController = STPAddCardViewController.init(configuration: paymentConfig, theme: theme)
                                    
                                    let address = STPAddress.init()
                                    address.name = self.name
                                    address.city = self.city
                                    address.country = "United Kingdom"
                                    address.postalCode = self.postcode
                                    address.line1 = self.street
                                    
                                    let info = STPUserInformation.init()
                                    info.billingAddress = address
                                    addCardViewController.prefilledInformation = info
                                    
                                    addCardViewController.delegate = self
                                    self.navigationController?.pushViewController(addCardViewController,animated: true)
                                    self.continueToPaymentButton?.isEnabled = true
                                    self.continueToPaymentButton?.alpha = 1.0
                                } else {
                                    StripeClient.shared.completeCashDelivery(with: self.finalPrice, note: self.note, time: self.deliveryCollectionTime, name: self.name, phoneNumber: self.phoneNumber, email: self.email, street: self.street, city: self.city, postcode: self.postcode, method: self.card, singleItems: BasketArrays.singleItems, multiItems: BasketArrays.multiItems, deviceToken: (Constants.deviceToken ?? "")!, ios: 1) { result in
                                        switch result {
                                        case .successChargeDelivery201:
                                            let alertController = UIAlertController(title: "Order Placed",
                                                                                    message: "Your payment was successful",
                                                                                    preferredStyle: .alert)
                                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                                BasketArrays.multiItems.removeAll()
                                                BasketArrays.singleItems.removeAll()
                                                BasketArrays.totalPriceSingle.removeAll()
                                                BasketArrays.totalPriceMulti.removeAll()
                                                BasketArrays.deals.removeAll()
                                                self.navigationController?.popToRootViewController(animated: true)
                                            })
                                            alertController.addAction(alertAction)
                                            self.present(alertController, animated: true)
                                        case .successChargeCollection202:
                                            let alertController = UIAlertController(title: "Order Placed",
                                                                                    message: "Your payment was successful",
                                                                                    preferredStyle: .alert)
                                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                                BasketArrays.multiItems.removeAll()
                                                BasketArrays.singleItems.removeAll()
                                                BasketArrays.totalPriceSingle.removeAll()
                                                BasketArrays.totalPriceMulti.removeAll()
                                                BasketArrays.deals.removeAll()
                                                self.navigationController?.popToRootViewController(animated: true)
                                            })
                                            alertController.addAction(alertAction)
                                            self.present(alertController, animated: true)
                                        case .successCashDelivery203:
                                            let alertController = UIAlertController(title: "Order Placed",
                                                                                    message: "Your order has been placed",
                                                                                    preferredStyle: .alert)
                                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                                BasketArrays.multiItems.removeAll()
                                                BasketArrays.singleItems.removeAll()
                                                BasketArrays.totalPriceSingle.removeAll()
                                                BasketArrays.totalPriceMulti.removeAll()
                                                BasketArrays.deals.removeAll()
                                                self.navigationController?.popToRootViewController(animated: true)
                                            })
                                            alertController.addAction(alertAction)
                                            self.present(alertController, animated: true)
                                        case .successCashCollection204:
                                            let alertController = UIAlertController(title: "Order Placed",
                                                                                    message: "Your order has been placed",
                                                                                    preferredStyle: .alert)
                                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                                BasketArrays.multiItems.removeAll()
                                                BasketArrays.singleItems.removeAll()
                                                BasketArrays.totalPriceSingle.removeAll()
                                                BasketArrays.totalPriceMulti.removeAll()
                                                BasketArrays.deals.removeAll()
                                                self.navigationController?.popToRootViewController(animated: true)
                                            })
                                            alertController.addAction(alertAction)
                                            self.present(alertController, animated: true)
                                        case .badRequestException306:
                                            let alertController = UIAlertController(title: "Data Error",
                                                                                    message: "It looks like something went wrong placing your order. If this continues, contact the takeaway directly.",
                                                                                    preferredStyle: .alert)
                                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                            })
                                            alertController.addAction(alertAction)
                                            self.present(alertController, animated: true)
                                            self.dismiss(animated: true, completion: nil)
                                        case .unauthorised307:
                                            let alertController = UIAlertController(title: "Server Error",
                                                                                    message: "There seems to be a problem with the AppsUKnow server. Contact the takeaway directly to place your order.",
                                                                                    preferredStyle: .alert)
                                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                            })
                                            alertController.addAction(alertAction)
                                            self.present(alertController, animated: true)
                                            self.dismiss(animated: true, completion: nil)
                                        case .invalidRequest308:
                                            let alertController = UIAlertController(title: "Server Error",
                                                                                    message: "There seems to be a problem with the AppsUKnow server. Contact the takeaway directly to place your order.",
                                                                                    preferredStyle: .alert)
                                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                            })
                                            alertController.addAction(alertAction)
                                            self.present(alertController, animated: true)
                                            self.dismiss(animated: true, completion: nil)
                                        case .notFound309:
                                            let alertController = UIAlertController(title: "Server Error",
                                                                                    message: "There seems to be a problem with the AppsUKnow server. Contact the takeaway directly to place your order.",
                                                                                    preferredStyle: .alert)
                                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                            })
                                            alertController.addAction(alertAction)
                                            self.present(alertController, animated: true)
                                            self.dismiss(animated: true, completion: nil)
                                        case .cardError310:
                                            let alertController = UIAlertController(title: "Card Error",
                                                                                    message: "There was a problem processing the payment with the supplied card details. Please check the details and try again.",
                                                                                    preferredStyle: .alert)
                                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                            })
                                            alertController.addAction(alertAction)
                                            self.present(alertController, animated: true)
                                            self.dismiss(animated: true, completion: nil)
                                        case .serverError311:
                                            let alertController = UIAlertController(title: "Server Error",
                                                                                    message: "There seems to be a problem with the AppsUKnow server. Contact the takeaway directly to place your order.",
                                                                                    preferredStyle: .alert)
                                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                            })
                                            alertController.addAction(alertAction)
                                            self.present(alertController, animated: true)
                                            self.dismiss(animated: true, completion: nil)
                                        case .amountMismatch312:
                                            let alertController = UIAlertController(title: "Price Change",
                                                                                    message: "It looks like the prices of the items in your basket have changed as you were placing your order. Please go back and add them again. Sorry for the inconvinence",
                                                                                    preferredStyle: .alert)
                                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                                BasketArrays.multiItems.removeAll()
                                                BasketArrays.singleItems.removeAll()
                                                BasketArrays.totalPriceSingle.removeAll()
                                                BasketArrays.totalPriceMulti.removeAll()
                                                BasketArrays.deals.removeAll()
                                                self.navigationController?.popToRootViewController(animated: true)
                                            })
                                            alertController.addAction(alertAction)
                                            self.present(alertController, animated: true)
                                        case .failure(_):
                                            let alertController = UIAlertController(title: "Unexpected Error",
                                                                                    message: "There was a problem processing your order. Please ensure all provided information is valid. If this continues, please contact the takeaway",
                                                                                    preferredStyle: .alert)
                                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                            })
                                            alertController.addAction(alertAction)
                                            self.present(alertController, animated: true)
                                            self.dismiss(animated: true, completion: nil)
                                        }
                                    }
                                }
                            } else {
                                let alertController = UIAlertController(title: "Whoops!",
                                                                        message: "This takeaway does not deliver to this area. You can order for collection instead.",
                                                                        preferredStyle: .alert)
                                let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                })
                                alertController.addAction(alertAction)
                                self.present(alertController, animated: true)
                                self.continueToPaymentButton?.isEnabled = true
                                self.continueToPaymentButton?.alpha = 1.0
                                self.tableView.reloadData()
                            }
                        }
                    } else {
                        if(self.name.isEmpty || self.phoneNumber.isEmpty || self.email.isEmpty) {
                            let alert = UIAlertController(title: "Error", message: "Please enter all collection information", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in}))
                            self.present(alert, animated: true, completion: nil)
                            self.continueToPaymentButton?.isEnabled = true
                            self.continueToPaymentButton?.alpha = 1.0
                        } else {
                            if(self.card == true) {
                                let paymentConfig = STPPaymentConfiguration.init();
                                paymentConfig.publishableKey = Constants.publishableKey!
                                paymentConfig.requiredBillingAddressFields = STPBillingAddressFields.full
                                let theme = STPTheme.default()
                                let addCardViewController = STPAddCardViewController.init(configuration: paymentConfig, theme: theme)
                                
                                let address = STPAddress.init()
                                address.name = self.name
                                address.city = self.city
                                address.country = "United Kingdom"
                                address.postalCode = self.postcode
                                address.line1 = self.street
                                
                                let info = STPUserInformation.init()
                                info.billingAddress = address
                                addCardViewController.prefilledInformation = info
                                
                                addCardViewController.delegate = self
                                
                                self.navigationController?.pushViewController(addCardViewController,animated: true)
                                self.continueToPaymentButton?.isEnabled = true
                                self.continueToPaymentButton?.alpha = 1.0
                            } else {
                                StripeClient.shared.completeCashCollection(with: self.finalPrice, note: self.note, time: self.deliveryCollectionTime, name: self.name, phoneNumber: self.phoneNumber, email: self.email, method: self.card, singleItems: BasketArrays.singleItems, multiItems: BasketArrays.multiItems, deviceToken: (Constants.deviceToken ?? "")!, ios: 1) { result in
                                    switch result {
                                    case .successChargeDelivery201:
                                        let alertController = UIAlertController(title: "Order Placed",
                                                                                message: "Your payment was successful",
                                                                                preferredStyle: .alert)
                                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                            BasketArrays.multiItems.removeAll()
                                            BasketArrays.singleItems.removeAll()
                                            BasketArrays.totalPriceSingle.removeAll()
                                            BasketArrays.totalPriceMulti.removeAll()
                                            BasketArrays.deals.removeAll()
                                            self.navigationController?.popToRootViewController(animated: true)
                                        })
                                        alertController.addAction(alertAction)
                                        self.present(alertController, animated: true)
                                    case .successChargeCollection202:
                                        let alertController = UIAlertController(title: "Order Placed",
                                                                                message: "Your payment was successful",
                                                                                preferredStyle: .alert)
                                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                            BasketArrays.multiItems.removeAll()
                                            BasketArrays.singleItems.removeAll()
                                            BasketArrays.totalPriceSingle.removeAll()
                                            BasketArrays.totalPriceMulti.removeAll()
                                            BasketArrays.deals.removeAll()
                                            self.navigationController?.popToRootViewController(animated: true)
                                        })
                                        alertController.addAction(alertAction)
                                        self.present(alertController, animated: true)
                                    case .successCashDelivery203:
                                        let alertController = UIAlertController(title: "Order Placed",
                                                                                message: "Your order has been placed",
                                                                                preferredStyle: .alert)
                                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                            BasketArrays.multiItems.removeAll()
                                            BasketArrays.singleItems.removeAll()
                                            BasketArrays.totalPriceSingle.removeAll()
                                            BasketArrays.totalPriceMulti.removeAll()
                                            BasketArrays.deals.removeAll()
                                            self.navigationController?.popToRootViewController(animated: true)
                                        })
                                        alertController.addAction(alertAction)
                                        self.present(alertController, animated: true)
                                    case .successCashCollection204:
                                        let alertController = UIAlertController(title: "Order Placed",
                                                                                message: "Your order has been placed",
                                                                                preferredStyle: .alert)
                                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                            BasketArrays.multiItems.removeAll()
                                            BasketArrays.singleItems.removeAll()
                                            BasketArrays.totalPriceSingle.removeAll()
                                            BasketArrays.totalPriceMulti.removeAll()
                                            BasketArrays.deals.removeAll()
                                            self.navigationController?.popToRootViewController(animated: true)
                                        })
                                        alertController.addAction(alertAction)
                                        self.present(alertController, animated: true)
                                    case .badRequestException306:
                                        let alertController = UIAlertController(title: "Data Error",
                                                                                message: "It looks like something went wrong placing your order. If this continues, contact the takeaway directly.",
                                                                                preferredStyle: .alert)
                                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                        })
                                        alertController.addAction(alertAction)
                                        self.present(alertController, animated: true)
                                    case .unauthorised307:
                                        let alertController = UIAlertController(title: "Server Error",
                                                                                message: "There seems to be a problem with the AppsUKnow server. Contact the takeaway directly to place your order.",
                                                                                preferredStyle: .alert)
                                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                        })
                                        alertController.addAction(alertAction)
                                        self.present(alertController, animated: true)
                                    case .invalidRequest308:
                                        let alertController = UIAlertController(title: "Server Error",
                                                                                message: "There seems to be a problem with the AppsUKnow server. Contact the takeaway directly to place your order.",
                                                                                preferredStyle: .alert)
                                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                        })
                                        alertController.addAction(alertAction)
                                        self.present(alertController, animated: true)
                                    case .notFound309:
                                        let alertController = UIAlertController(title: "Server Error",
                                                                                message: "There seems to be a problem with the AppsUKnow server. Contact the takeaway directly to place your order.",
                                                                                preferredStyle: .alert)
                                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                        })
                                        alertController.addAction(alertAction)
                                        self.present(alertController, animated: true)
                                    case .cardError310:
                                        let alertController = UIAlertController(title: "Card Error",
                                                                                message: "There was a problem processing the payment with the supplied card details. Please check the details and try again.",
                                                                                preferredStyle: .alert)
                                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                        })
                                        alertController.addAction(alertAction)
                                        self.present(alertController, animated: true)
                                    case .serverError311:
                                        let alertController = UIAlertController(title: "Server Error",
                                                                                message: "There seems to be a problem with the AppsUKnow server. Contact the takeaway directly to place your order.",
                                                                                preferredStyle: .alert)
                                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                        })
                                        alertController.addAction(alertAction)
                                        self.present(alertController, animated: true)
                                    case .amountMismatch312:
                                        let alertController = UIAlertController(title: "Price Change",
                                                                                message: "It looks like the prices of the items in your basket have changed as you were placing your order. Please go back and add them again. Sorry for the inconvinence",
                                                                                preferredStyle: .alert)
                                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                            BasketArrays.multiItems.removeAll()
                                            BasketArrays.singleItems.removeAll()
                                            BasketArrays.totalPriceSingle.removeAll()
                                            BasketArrays.totalPriceMulti.removeAll()
                                            BasketArrays.deals.removeAll()
                                            self.navigationController?.popToRootViewController(animated: true)
                                        })
                                        alertController.addAction(alertAction)
                                        self.present(alertController, animated: true)
                                    case .failure(_):
                                        let alertController = UIAlertController(title: "Unexpected Error",
                                                                                message: "There was a problem processing your order. Please ensure all provided information is valid. If this continues, please contact the takeaway",
                                                                                preferredStyle: .alert)
                                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                        })
                                        alertController.addAction(alertAction)
                                        self.present(alertController, animated: true)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
}

extension NameAddressTableViewController: STPAddCardViewControllerDelegate {
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func clearBasket() {
        BasketArrays.multiItems.removeAll()
        BasketArrays.singleItems.removeAll()
        BasketArrays.totalPriceSingle.removeAll()
        BasketArrays.totalPriceMulti.removeAll()
        BasketArrays.deals.removeAll()
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController,
                               didCreateToken token: STPToken,
                               completion: @escaping STPErrorBlock) {
        if(self.delivery == true) {
            StripeClient.shared.completeChargeDelivery(with: token, amount: self.finalPrice, note: self.note, time: self.deliveryCollectionTime, name: self.name, phoneNumber: self.phoneNumber, email: self.email, street: self.street, city: self.city, postcode: self.postcode, method: self.card, singleItems: BasketArrays.singleItems, multiItems: BasketArrays.multiItems, deviceToken: (Constants.deviceToken ?? "")!, ios: 1) { result in
                switch result {
                case .successChargeDelivery201:
                    let alertController = UIAlertController(title: "Order Placed",
                                                            message: "Your payment was successful",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.clearBasket()
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                case .successChargeCollection202:
                    let alertController = UIAlertController(title: "Order Placed",
                                                            message: "Your payment was successful",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.clearBasket()
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                case .successCashDelivery203:
                    let alertController = UIAlertController(title: "Order Placed",
                                                            message: "Your order has been placed",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.clearBasket()
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                case .successCashCollection204:
                    let alertController = UIAlertController(title: "Order Placed",
                                                            message: "Your order has been placed",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.clearBasket()
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                case .badRequestException306:
                    let alertController = UIAlertController(title: "Data Error",
                                                            message: "It looks like something went wrong placing your order. If this continues, contact the takeaway directly.",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                    completion(nil)
                case .unauthorised307:
                    let alertController = UIAlertController(title: "Server Error",
                                                            message: "There seems to be a problem with the AppsUKnow server. Contact the takeaway directly to place your order.",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                    completion(nil)
                case .invalidRequest308:
                    let alertController = UIAlertController(title: "Server Error",
                                                            message: "There seems to be a problem with the AppsUKnow server. Contact the takeaway directly to place your order.",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                    completion(nil)
                case .notFound309:
                    let alertController = UIAlertController(title: "Server Error",
                                                            message: "There seems to be a problem with the AppsUKnow server. Contact the takeaway directly to place your order.",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                    completion(nil)
                case .cardError310:
                    let alertController = UIAlertController(title: "Card Error",
                                                            message: "There was a problem processing the payment with the supplied card details. Please check the details and try again.",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                    completion(nil)
                case .serverError311:
                    let alertController = UIAlertController(title: "Server Error",
                                                            message: "There seems to be a problem with the AppsUKnow server. Contact the takeaway directly to place your order.",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                    completion(nil)
                case .amountMismatch312:
                    let alertController = UIAlertController(title: "Price Change",
                                                            message: "It looks like the prices of the items in your basket have changed as you were placing your order. Please go back and add them again. Sorry for the inconvinence",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.clearBasket()
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                case .failure(_):
                    let alertController = UIAlertController(title: "Unexpected Error",
                                                            message: "There was a problem processing your order. Please ensure all provided information is valid. If this continues, please contact the takeaway",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                    completion(nil)
                }
            }
        } else {
            StripeClient.shared.completeChargeCollection(with: token, amount: self.finalPrice, note: self.note, time: self.deliveryCollectionTime, name: self.name, phoneNumber: self.phoneNumber, email: self.email, method: self.card, singleItems: BasketArrays.singleItems, multiItems: BasketArrays.multiItems, deviceToken: (Constants.deviceToken ?? "")!, ios: 1) { result in
                switch result {
                case .successChargeDelivery201:
                    let alertController = UIAlertController(title: "Order Placed",
                                                            message: "Your payment was successful",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.clearBasket()
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                case .successChargeCollection202:
                    let alertController = UIAlertController(title: "Order Placed",
                                                            message: "Your payment was successful",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.clearBasket()
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                case .successCashDelivery203:
                    let alertController = UIAlertController(title: "Order Placed",
                                                            message: "Your order has been placed",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.clearBasket()
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                case .successCashCollection204:
                    let alertController = UIAlertController(title: "Order Placed",
                                                            message: "Your order has been placed",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.clearBasket()
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                case .badRequestException306:
                    let alertController = UIAlertController(title: "Data Error",
                                                            message: "It looks like something went wrong placing your order. If this continues, contact the takeaway directly.",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                    completion(nil)
                case .unauthorised307:
                    let alertController = UIAlertController(title: "Server Error",
                                                            message: "There seems to be a problem with the AppsUKnow server. Contact the takeaway directly to place your order.",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                    completion(nil)
                case .invalidRequest308:
                    let alertController = UIAlertController(title: "Server Error",
                                                            message: "There seems to be a problem with the AppsUKnow server. Contact the takeaway directly to place your order.",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                    completion(nil)
                case .notFound309:
                    let alertController = UIAlertController(title: "Server Error",
                                                            message: "There seems to be a problem with the AppsUKnow server. Contact the takeaway directly to place your order.",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                    completion(nil)
                case .cardError310:
                    let alertController = UIAlertController(title: "Card Error",
                                                            message: "There was a problem processing the payment with the supplied card details. Please check the details and try again.",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                    completion(nil)
                case .serverError311:
                    let alertController = UIAlertController(title: "Server Error",
                                                            message: "There seems to be a problem with the AppsUKnow server. Contact the takeaway directly to place your order.",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                    completion(nil)
                case .amountMismatch312:
                    let alertController = UIAlertController(title: "Price Change",
                                                            message: "It looks like the prices of the items in your basket have changed as you were placing your order. Please go back and add them again. Sorry for the inconvinence",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.clearBasket()
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                case .failure(_):
                    let alertController = UIAlertController(title: "Unexpected Error",
                                                            message: "There was a problem processing your order. Please ensure all provided information is valid. If this continues, please contact the takeaway",
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                    completion(nil)
                }
            }
        }
        
    }
}
