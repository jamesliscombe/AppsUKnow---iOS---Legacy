//
//  DealItemsTableViewController.swift
//  prototype
//
//  Created by James Liscombe on 07/10/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class DealItemsTableViewController: UITableViewController, DealItemsChoicesTableViewControllerProtocol, AddToBasketTableViewCellProtocol {
    //MARK: - Properties and computed variables
    var selectedDeal = String()
    var selectedDealSections = Int()
    var selectedDealId = String()
    var selectedDealPrice = Double()
    let dispatchGroupLoadDealItems = DispatchGroup()
    var selectedDealDescription: String?
    
    var dealChoices: Dictionary = [String:String]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    lazy var refreshTableView: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshTableViewLogic), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        if !Reachability.isConnectedToNetwork(){
            print("Internet Connection not Available!")
            noInternetConnection()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = UIImageView(image: UIImage(named: "Background"))
        tableView.refreshControl = refreshTableView
        
        let dealChoiceTableViewCellNib = UINib(nibName: "DealChoiceTableViewCell", bundle: nil)
        tableView.register(dealChoiceTableViewCellNib, forCellReuseIdentifier: "DealChoiceTableViewCell")
        
        let addToBasketTableViewCellNib = UINib(nibName: "AddToBasketTableViewCell", bundle: nil)
        tableView.register(addToBasketTableViewCellNib, forCellReuseIdentifier: "AddToBasketTableViewCell")
        
        let dealDescriptionTableViewCellNib = UINib(nibName: "DealDescriptionTableViewCell", bundle: nil)
        tableView.register(dealDescriptionTableViewCellNib, forCellReuseIdentifier: "DealDescriptionTableViewCell")
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _ = calculateTitleOfBasketButton()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if(self.selectedDealDescription?.count == 0) {
            return 2
        } else {
            return 3
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.selectedDealDescription?.count == 0) {
            if(section == 0) {
                return self.selectedDealSections
            } else {
                return 1
            }
        } else {
            if(section == 0) {
                return 1
            } else if(section == 1) {
                return self.selectedDealSections
            } else {
                return 1
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(self.selectedDealDescription?.count == 0) {
            if(indexPath.section == 0) {
                let dealChoiceTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DealChoiceTableViewCell", for: indexPath) as! DealChoiceTableViewCell
                dealChoiceTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                
                if(dealChoices[String(indexPath.row)] != nil) {
                    dealChoiceTableViewCell.choiceLabel.text = dealChoices[String(indexPath.row)]
                } else {
                    dealChoiceTableViewCell.choiceLabel.text = "Choice "+String(indexPath.row+1)
                }
                return dealChoiceTableViewCell
            } else {
                let addToBasketTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AddToBasketTableViewCell", for: indexPath) as! AddToBasketTableViewCell
                addToBasketTableViewCell.delegate = self
                
                if(dealChoices.count != selectedDealSections) {
                    addToBasketTableViewCell.goToCheckoutButton.isEnabled = false
                    addToBasketTableViewCell.goToCheckoutButton.alpha = 0.2
                } else {
                    addToBasketTableViewCell.goToCheckoutButton.isEnabled = true
                    addToBasketTableViewCell.goToCheckoutButton.alpha = 1.0
                }
                
                addToBasketTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                return addToBasketTableViewCell
            }
        } else {
            if(indexPath.section == 0) {
                let descriptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DealDescriptionTableViewCell", for: indexPath) as! DealDescriptionTableViewCell
                descriptionTableViewCell.dealDescriptionLabel.text = self.selectedDealDescription
                descriptionTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                return descriptionTableViewCell
            } else if (indexPath.section == 1) {
                let dealChoiceTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DealChoiceTableViewCell", for: indexPath) as! DealChoiceTableViewCell
                dealChoiceTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                
                if(dealChoices[String(indexPath.row)] != nil) {
                    dealChoiceTableViewCell.choiceLabel.text = dealChoices[String(indexPath.row)]
                } else {
                    dealChoiceTableViewCell.choiceLabel.text = "Choice "+String(indexPath.row+1)
                }
                return dealChoiceTableViewCell
            } else {
                let addToBasketTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AddToBasketTableViewCell", for: indexPath) as! AddToBasketTableViewCell
                addToBasketTableViewCell.delegate = self
                
                if(dealChoices.count != selectedDealSections) {
                    addToBasketTableViewCell.goToCheckoutButton.isEnabled = false
                    addToBasketTableViewCell.goToCheckoutButton.alpha = 0.2
                } else {
                    addToBasketTableViewCell.goToCheckoutButton.isEnabled = true
                    addToBasketTableViewCell.goToCheckoutButton.alpha = 1.0
                }
                
                addToBasketTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                return addToBasketTableViewCell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.selectedDealDescription?.count == 0) {
            if(indexPath.section == 0) {
                let vc = storyboard?.instantiateViewController(withIdentifier: "DealItemsChoicesTableViewController") as! DealItemsChoicesTableViewController
                vc.section = String(indexPath.row)
                vc.dealID = self.selectedDealId
                vc.delegate = self
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if(indexPath.section == 1) {
                let vc = storyboard?.instantiateViewController(withIdentifier: "DealItemsChoicesTableViewController") as! DealItemsChoicesTableViewController
                vc.section = String(indexPath.row)
                vc.dealID = self.selectedDealId
                vc.delegate = self
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    //MARK: - Custom functions
    
    //MARK: - Objc functions
    @objc func refreshTableViewLogic() {
        let refreshDelay = DispatchTime.now() + .milliseconds(500)
        DispatchQueue.main.asyncAfter(deadline: refreshDelay) {
            self.refreshTableView.endRefreshing()
            //self.loadDealItems()
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Protocols
    func choiceMade(viewController: DealItemsChoicesTableViewController) {
        self.dealChoices.updateValue(viewController.decision, forKey: viewController.section)
    }
    
    func addToBasket() {
        let choices = Array(self.dealChoices.values)
        
        let deal = Deals()
        deal.choices = choices
        deal.id = self.selectedDealId
        deal.name = self.selectedDeal
        deal.price = self.selectedDealPrice
        
        BasketArrays.deals.append(deal)
        
        let alertController = UIAlertController(title: "Success",
                                                message: "Deal added to basket",
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        })
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
        _ = calculateTitleOfBasketButton()
    }
}
