//
//  BasketTableViewController.swift
//  prototype
//
//  Created by James Liscombe on 02/08/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class BasketTableViewController: UITableViewController, DeliveryCollectionTableViewCellProtocol, BasketItemTableViewCellProtocol, GoToCheckoutButtonTableViewCellProtocol {
    
    //MARK: - Properties and computed variables
    var basket = BasketArrays()
    var itemsInBasket = [ItemDetailModel]()
    var multiItemsInBasket = [MultiItemDetailModel]()
    let dispatchGroupLoadItems = DispatchGroup()
    
    lazy var loadingTableView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        return activityIndicator
    }()
    
    var basketEmpty: Bool {
        if(basket.countOfItems() > 0) {
            return false
        } else {
            return true
        }
    }
    
    var delivery = true {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    //MARK: - TableView functions (overrides)
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        if(!basketEmpty == true) {
            startActivityIndicator()
        }
        
        if (!Reachability.isConnectedToNetwork()) {
            print("Internet Connection not Available!")
            noInternetConnection()
        }
        
        //Empty Cells
        let orderEmptyInfoTableViewCellNib = UINib(nibName: "OrderEmptyInfoTableViewCell", bundle: nil)
        tableView.register(orderEmptyInfoTableViewCellNib, forCellReuseIdentifier: "OrderEmptyInfoTableViewCell")
        
        //Not Empty Cells
        let deliveryCollectionTimesTableViewCellNib = UINib(nibName: "DeliveryCollectionTimesTableViewCell", bundle: nil)
        tableView.register(deliveryCollectionTimesTableViewCellNib, forCellReuseIdentifier: "DeliveryCollectionTimesTableViewCell")
        
        let basketInfoTableViewCellNib = UINib(nibName: "BasketInfoTableViewCell", bundle: nil)
        tableView.register(basketInfoTableViewCellNib, forCellReuseIdentifier: "BasketInfoTableViewCell")
        
        let allergyTableViewCellNib = UINib(nibName: "AllergyTableViewCell", bundle: nil)
        tableView.register(allergyTableViewCellNib, forCellReuseIdentifier: "AllergyTableViewCell")
        
        let minimumOrderForDeliveryNotReachedTableViewCellNib = UINib(nibName: "MinimumOrderForDeliveryNotReachedTableViewCell", bundle: nil)
        tableView.register(minimumOrderForDeliveryNotReachedTableViewCellNib, forCellReuseIdentifier: "MinimumOrderForDeliveryNotReachedTableViewCell")
        
        let deliveryCollectionTableViewCellNib = UINib(nibName: "DeliveryCollectionTableViewCell", bundle: nil)
        tableView.register(deliveryCollectionTableViewCellNib, forCellReuseIdentifier: "DeliveryCollectionTableViewCell")
        
        let basketItemTableViewCellNib = UINib(nibName: "BasketItemTableViewCell", bundle: nil)
        tableView.register(basketItemTableViewCellNib, forCellReuseIdentifier: "BasketItemTableViewCell")
        
        let dealBasketTableViewCellNib = UINib(nibName: "DealBasketTableViewCell", bundle: nil)
        tableView.register(dealBasketTableViewCellNib, forCellReuseIdentifier: "DealBasketTableViewCell")
        
        let deliveryOrderSummaryTableViewCellNib = UINib(nibName: "DeliveryOrderSummaryTableViewCell", bundle: nil)
        tableView.register(deliveryOrderSummaryTableViewCellNib, forCellReuseIdentifier: "DeliveryOrderSummaryTableViewCell")
        
        let collectionOrderSummaryTableViewCellNib = UINib(nibName: "CollectionOrderSummaryTableViewCell", bundle: nil)
        tableView.register(collectionOrderSummaryTableViewCellNib, forCellReuseIdentifier: "CollectionOrderSummaryTableViewCell")
        
        //Checkout Button
        let goToCheckoutButtonTableViewCellNib = UINib(nibName: "GoToCheckoutButtonTableViewCell", bundle: nil)
        tableView.register(goToCheckoutButtonTableViewCellNib, forCellReuseIdentifier: "GoToCheckoutButtonTableViewCell")
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "Background"))
        
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if(basketEmpty == true) {
            return 1
        } else {
            return 6
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(basketEmpty == true) {
            return 2
        } else {
            if(section == 0) {
                return 1
            } else if(section == 1) {
                return 5
            } else if (section == 2) {
                return itemsInBasket.count
            } else if (section == 3) {
                return multiItemsInBasket.count
            } else if (section == 4) {
                return BasketArrays.deals.count
            } else {
                return 1
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(basketEmpty == false && indexPath.section == 1 && indexPath.row == 4) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "AllergyTableViewController") as! AllergyTableViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(basketEmpty == true) {
            if(indexPath.row == 0) {
                let orderEmptyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OrderEmptyInfoTableViewCell", for: indexPath) as! OrderEmptyInfoTableViewCell
                orderEmptyInfoTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                return orderEmptyInfoTableViewCell
            } else {
                let goToCheckoutButtonTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GoToCheckoutButtonTableViewCell", for: indexPath) as! GoToCheckoutButtonTableViewCell
                goToCheckoutButtonTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                goToCheckoutButtonTableViewCell.checkoutButton.isEnabled = false
                goToCheckoutButtonTableViewCell.checkoutButton.alpha = 0.2
                return goToCheckoutButtonTableViewCell
            }
        } else {
            if(indexPath.section == 0) {
                let deliveryCollectionTimesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DeliveryCollectionTimesTableViewCell", for: indexPath) as! DeliveryCollectionTimesTableViewCell
                deliveryCollectionTimesTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                
                if(delivery == true) {
                    deliveryCollectionTimesTableViewCell.deliveryTimeLabel.text = "Average Delivery Time: \(Constants.avgDeliveryTime!) minutes"
                } else {
                    deliveryCollectionTimesTableViewCell.deliveryTimeLabel.text = "Average Collection Time: \(Constants.avgCollectionTime!) minutes"
                }
                
                return deliveryCollectionTimesTableViewCell
            } else if(indexPath.section == 1) {
                if(indexPath.row == 0) {
                    let minimumOrderForDeliveryNotReachedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MinimumOrderForDeliveryNotReachedTableViewCell", for: indexPath) as! MinimumOrderForDeliveryNotReachedTableViewCell
                    minimumOrderForDeliveryNotReachedTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                    
                    if(self.delivery == true) {
                        minimumOrderForDeliveryNotReachedTableViewCell.minAmountHit = false
                        if(basket.totalPriceOfAllItems() < Double(BasketArrays.minOrder)!) {
                            minimumOrderForDeliveryNotReachedTableViewCell.minAmountHit = false
                        } else {
                            minimumOrderForDeliveryNotReachedTableViewCell.minAmountHit = true
                        }
                    } else {
                        minimumOrderForDeliveryNotReachedTableViewCell.minAmountHit = true
                    }
                    
                    return minimumOrderForDeliveryNotReachedTableViewCell
                } else if(indexPath.row == 1) {
                    let basketInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BasketInfoTableViewCell", for: indexPath) as! BasketInfoTableViewCell
                    basketInfoTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                    
                    if(delivery == true) {
                        basketInfoTableViewCell.priceTotalLabel.text = String(format: "£%.02f",basket.totalPriceOfAllItems() + Double(BasketArrays.deliveryCharge)!)
                    } else {
                        basketInfoTableViewCell.priceTotalLabel.text = String(format: "£%.02f",basket.totalPriceOfAllItems())
                    }
                    
                    if(basket.countOfItems() == 1) {
                        basketInfoTableViewCell.itemsTotalLabel.text = String(basket.countOfItems())+" item"
                    } else {
                        basketInfoTableViewCell.itemsTotalLabel.text = String(basket.countOfItems())+" items"
                    }
                    
                    return basketInfoTableViewCell
                } else if(indexPath.row == 2) {
                    let deliveryCollectionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DeliveryCollectionTableViewCell", for: indexPath) as! DeliveryCollectionTableViewCell
                    deliveryCollectionTableViewCell.delegate = self
                    deliveryCollectionTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                    return deliveryCollectionTableViewCell
                } else if(indexPath.row == 3) {
                    let goToCheckoutButtonTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GoToCheckoutButtonTableViewCell", for: indexPath) as! GoToCheckoutButtonTableViewCell
                    goToCheckoutButtonTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                    goToCheckoutButtonTableViewCell.delegate = self
                    if(self.delivery == true && basket.totalPriceOfAllItems() < Double(BasketArrays.minOrder)!) {
                        goToCheckoutButtonTableViewCell.checkoutButton.isEnabled = false
                        goToCheckoutButtonTableViewCell.checkoutButton.alpha = 0.2
                    } else {
                        goToCheckoutButtonTableViewCell.checkoutButton.isEnabled = true
                        goToCheckoutButtonTableViewCell.checkoutButton.alpha = 1
                    }
                    return goToCheckoutButtonTableViewCell
                } else {
                    let allergyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AllergyTableViewCell", for: indexPath) as! AllergyTableViewCell
                    allergyTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                    return allergyTableViewCell
                }
            } else if (indexPath.section == 2) {
                //Single items
                let basketItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BasketItemTableViewCell", for: indexPath) as! BasketItemTableViewCell
                basketItemTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                basketItemTableViewCell.delegate = self
                basketItemTableViewCell.singleItem = true
                basketItemTableViewCell.item_id = String(itemsInBasket[indexPath.row].ID!)
                let count = BasketArrays.singleItems[String(itemsInBasket[indexPath.row].ID!)]
                basketItemTableViewCell.itemQuantityTextField.text = String(count!)
                basketItemTableViewCell.itemPriceLabel.text = String(format: "£%.02f",(Double(itemsInBasket[indexPath.row].price!)! * Double(count!)))
                basketItemTableViewCell.itemNameLabel.text = itemsInBasket[indexPath.row].name!
                basketItemTableViewCell.itemPrice = Double(itemsInBasket[indexPath.row].price!)
                return basketItemTableViewCell
            } else if (indexPath.section == 3) {
                //Multi Items
                let basketItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BasketItemTableViewCell", for: indexPath) as! BasketItemTableViewCell
                basketItemTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                basketItemTableViewCell.delegate = self
                basketItemTableViewCell.singleItem = false
                basketItemTableViewCell.item_id = String(multiItemsInBasket[indexPath.row].ID!)
                let count = BasketArrays.multiItems[String(multiItemsInBasket[indexPath.row].ID!)]
                basketItemTableViewCell.itemQuantityTextField.text = String(count!)
                basketItemTableViewCell.itemPriceLabel.text = String(format: "£%.02f",(Double(multiItemsInBasket[indexPath.row].price!)! * Double(count!)))
                basketItemTableViewCell.itemNameLabel.text = "\(multiItemsInBasket[indexPath.row].name!)"
                basketItemTableViewCell.itemPrice = Double(multiItemsInBasket[indexPath.row].price!)
                return basketItemTableViewCell
            } else if (indexPath.section == 4) {
                //DEALS
                let deal = BasketArrays.deals[indexPath.row]
                var choices = [String]()
                for(choice) in deal.choices! {
                    choices.append("\n")
                    choices.append(contentsOf:[choice])
                }
                let dealBasketTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DealBasketTableViewCell", for: indexPath) as! DealBasketTableViewCell
                dealBasketTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                
                var myMutableString = NSMutableAttributedString()
                
                let range = BasketArrays.deals[indexPath.row].name!
                
                myMutableString = NSMutableAttributedString(
                    string: BasketArrays.deals[indexPath.row].name! + "\n" + choices.joined(),
                    attributes: [NSAttributedString.Key.font:UIFont(
                        name: "Avenir-Book",
                        size: 16.0)!])
                myMutableString.addAttribute(NSAttributedString.Key.font,
                                             value: UIFont(
                                                name: "Avenir-Medium",
                                                size: 16.0)!,
                                             range:NSRange(location: 0,
                                                           length: range.count))
                
                dealBasketTableViewCell.dealInfoLabel.attributedText = myMutableString
                dealBasketTableViewCell.dealPrice.text = String(format: "£%.02f", BasketArrays.deals[indexPath.row].price!)
                
                return dealBasketTableViewCell
            } else {
                if(delivery == true) {
                    let deliveryOrderSummaryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DeliveryOrderSummaryTableViewCell", for: indexPath) as! DeliveryOrderSummaryTableViewCell
                    deliveryOrderSummaryTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                    deliveryOrderSummaryTableViewCell.subtotalLabel.text = String(format: "£%.02f",basket.totalPriceOfAllItems())
                    deliveryOrderSummaryTableViewCell.deliveryChargeLabel.text = "£\(BasketArrays.deliveryCharge)"
                    deliveryOrderSummaryTableViewCell.totalLabel.text = String(format: "£%.02f",basket.totalPriceOfAllItems() + Double(BasketArrays.deliveryCharge)!)
                    return deliveryOrderSummaryTableViewCell
                } else {
                    let collectionOrderSummaryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CollectionOrderSummaryTableViewCell", for: indexPath) as! CollectionOrderSummaryTableViewCell
                    collectionOrderSummaryTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                    collectionOrderSummaryTableViewCell.subtotalLabel.text = String(format: "£%.02f",basket.totalPriceOfAllItems())
                    collectionOrderSummaryTableViewCell.totalLabel.text = String(format: "£%.02f",basket.totalPriceOfAllItems())
                    return collectionOrderSummaryTableViewCell
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if(basketEmpty == false) {
            if(indexPath.section == 2) {
                return true
            } else if(indexPath.section == 3) {
                return true
            } else if (indexPath.section == 4) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showDeliveryCollectionTime") {
            let deliveryCollectionTimeTableViewController = segue.destination as! DeliveryCollectionTimeTableViewController
            if(delivery == true) {
                deliveryCollectionTimeTableViewController.delivery = true
            } else {
                deliveryCollectionTimeTableViewController.delivery = false
            }
            deliveryCollectionTimeTableViewController.show(self, sender: nil)
        }
    }
    
    //MARK: - Custom functions
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action,view,completion) in
            if(indexPath.section ==  2) {
                BasketArrays.singleItems.removeValue(forKey: String(self.itemsInBasket[indexPath.row].ID!))
                BasketArrays.totalPriceSingle.removeValue(forKey: String(self.itemsInBasket[indexPath.row].ID!))
                self.itemsInBasket.remove(at: indexPath.row)
                self.tableView.reloadData()
            } else if (indexPath.section == 3) {
                BasketArrays.multiItems.removeValue(forKey: String(self.multiItemsInBasket[indexPath.row].ID!))
                BasketArrays.totalPriceMulti.removeValue(forKey: String(self.multiItemsInBasket[indexPath.row].ID!))
                self.multiItemsInBasket.remove(at: indexPath.row)
                self.tableView.reloadData()
            } else if (indexPath.section == 4) {
                //BasketArrays.dealQuantity -= 1
                BasketArrays.deals.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "trash")
        action.backgroundColor = .red
        return action
    }
    
    func startActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingTableView.center = self.tableView.center
            self.loadingTableView.style = UIActivityIndicatorView.Style.gray
            self.tableView.addSubview(self.loadingTableView)
            self.loadingTableView.startAnimating()
            if(BasketArrays.singleItems.count > 0) {
                self.loadSingleItems()
            }
            if(BasketArrays.multiItems.count > 0) {
                self.loadMultiItems()
            }
            self.loadingTableView.stopAnimating()
        }
    }
    
    func loadSingleItems() {
        let lazyMapCollection = BasketArrays.singleItems.keys
        let stringArray = Array(lazyMapCollection)
        let urlApi = Constants.baseURLString+"wp-json/appsuknow/v1/select/items/\(stringArray.joined(separator: ","))"
        
        print(urlApi)
        
        guard let url = URL(string: urlApi) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            do {
                self.dispatchGroupLoadItems.enter()
                self.itemsInBasket = try JSONDecoder().decode([ItemDetailModel].self, from: data)
                self.dispatchGroupLoadItems.leave()
                
                self.dispatchGroupLoadItems.notify(queue: .main) {
                    self.tableView.reloadData()
                }
            } catch let JSONerror {
                print("There was an error decoding single items", JSONerror)
            }
            
            }.resume()
    }
    
    func loadMultiItems() {
        let lazyMapCollection = BasketArrays.multiItems.keys
        let stringArray = Array(lazyMapCollection)
        let urlApi = Constants.baseURLString+"wp-json/appsuknow/v1/select/multi_items/\(stringArray.joined(separator: ","))"
        
        print(urlApi)
        
        guard let url = URL(string: urlApi) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            do {
                self.dispatchGroupLoadItems.enter()
                self.multiItemsInBasket = try JSONDecoder().decode([MultiItemDetailModel].self, from: data)
                self.dispatchGroupLoadItems.leave()
                
                self.dispatchGroupLoadItems.notify(queue: .main) {
                    self.tableView.reloadData()
                }
            } catch let JSONerror {
                print("There was an error decoding multi items", JSONerror)
            }
            
            }.resume()
    }
    
    //MARK: - Objc functions
    
    //MARK: - Protocols
    func deliveryCollectionChoice(choice: String) {
        if(choice == "delivery") {
            self.delivery = true
        } else {
            self.delivery = false
        }
    }
    
    func updatedAmount() {
        self.tableView.reloadData()
    }
    
    func goToCheckoutButtonPressed() {
        performSegue(withIdentifier: "showDeliveryCollectionTime", sender: nil)
    }
}
