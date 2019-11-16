//
//  itemsTableViewController.swift
//  prototype
//
//  Created by James Liscombe on 11/07/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController, AddSingleItemWithDescriptionToBasketButtonProtocol {

    //MARK: - Properties and computed variables
    var items = [ItemsModel]()
    lazy var selectedCategoryID = Int()
    lazy var selectedCategoryName = String()
    lazy var selectedCategoryDescription = String()
    lazy var item_id = String()
    let dispatchGroupLoadItems = DispatchGroup()
    
    lazy var refreshTableView: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshTableViewLogic), for: .valueChanged)
        return refreshControl
    }()
    
    lazy var loadingTableView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        return activityIndicator
    }()
    
    //MARK: - TableView functions (overrides)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _ = calculateTitleOfBasketButton()
    }

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = selectedCategoryName
        if (!Reachability.isConnectedToNetwork()){
            print("Internet Connection not Available!")
            noInternetConnection()
        }
        //tableView.backgroundView = UIImageView(image: UIImage(named: "Background"))
        tableView.backgroundColor = UIColor.black
        tableView.refreshControl = refreshTableView
        
        let descriptionTableViewCell = UINib(nibName: "DescriptionTableViewCell", bundle: nil)
        tableView.register(descriptionTableViewCell, forCellReuseIdentifier: "DescriptionTableViewCell")
        
        let itemWithDescriptionTableViewCell = UINib(nibName: "ItemWithDescriptionTableViewCell", bundle: nil)
        tableView.register(itemWithDescriptionTableViewCell, forCellReuseIdentifier: "ItemWithDescriptionTableViewCell")
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.tableFooterView = UIView()
        
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(self.selectedCategoryDescription.count == 0) {
            let itemWithDescriptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ItemWithDescriptionTableViewCell", for: indexPath) as! ItemWithDescriptionTableViewCell
            itemWithDescriptionTableViewCell.delegate = self
            itemWithDescriptionTableViewCell.multi = String(items[indexPath.row].has_children!)
            itemWithDescriptionTableViewCell.item_id = String(items[indexPath.row].ID!)
            
            if(items[indexPath.row].has_children == "Yes") {
                itemWithDescriptionTableViewCell.itemFromLabel.text = "From: £"
                itemWithDescriptionTableViewCell.itemPriceLabel.text = items[indexPath.row].price
            } else {
                itemWithDescriptionTableViewCell.itemFromLabel.text = "£"
                itemWithDescriptionTableViewCell.itemPriceLabel.text = items[indexPath.row].price
            }
            
            itemWithDescriptionTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
            itemWithDescriptionTableViewCell.itemNameLabel.text = items[indexPath.row].name
            itemWithDescriptionTableViewCell.itemDescriptionLabel.text = items[indexPath.row].description
            return itemWithDescriptionTableViewCell
        } else {
            if(indexPath.section == 0) {
                let descriptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath) as! DescriptionTableViewCell
                descriptionTableViewCell.categoryDescriptionLabel.text = self.selectedCategoryDescription
                descriptionTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                return descriptionTableViewCell
            } else {
                let itemWithDescriptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ItemWithDescriptionTableViewCell", for: indexPath) as! ItemWithDescriptionTableViewCell
                itemWithDescriptionTableViewCell.delegate = self
                itemWithDescriptionTableViewCell.multi = String(items[indexPath.row].has_children!)
                itemWithDescriptionTableViewCell.item_id = String(items[indexPath.row].ID!)
                
                if(items[indexPath.row].has_children == "Yes") {
                    itemWithDescriptionTableViewCell.itemFromLabel.text = "From: £"
                    itemWithDescriptionTableViewCell.itemPriceLabel.text = items[indexPath.row].price
                } else {
                    itemWithDescriptionTableViewCell.itemFromLabel.text = "£"
                    itemWithDescriptionTableViewCell.itemPriceLabel.text = items[indexPath.row].price
                }
                    
                itemWithDescriptionTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                itemWithDescriptionTableViewCell.itemNameLabel.text = items[indexPath.row].name
                itemWithDescriptionTableViewCell.itemDescriptionLabel.text = items[indexPath.row].description
                return itemWithDescriptionTableViewCell
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        if (self.selectedCategoryDescription.count == 0) {
            return 1
        } else {
            return 2
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.selectedCategoryDescription.count == 0) {
                return items.count
        } else {
            if (section == 0) {
                return 1
            } else {
                return items.count
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showMultiItems") {
            if let destinationVC = segue.destination as? MultiItemsTableViewController {
                destinationVC.item_id = self.item_id
            }
        }
    }
    
    //MARK: - Custom functions
    func startActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingTableView.center = self.tableView.center
            self.loadingTableView.style = UIActivityIndicatorView.Style.gray
            self.tableView.addSubview(self.loadingTableView)
            self.loadingTableView.startAnimating()
            self.loadItems()
            self.loadingTableView.stopAnimating()
        }
    }
    
    //MARK: - Objc functions
    @objc func loadItems() {
        let selectedCategory = self.selectedCategoryID
        let urlApi = Constants.baseURLString+"wp-json/appsuknow/v1/item/"+String(selectedCategory)
    
        guard let url = URL(string: urlApi) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            do {
                self.dispatchGroupLoadItems.enter()
                self.items = try JSONDecoder().decode([ItemsModel].self, from: data)
                self.dispatchGroupLoadItems.leave()
                
                self.dispatchGroupLoadItems.notify(queue: .main) {
                    self.tableView.reloadData()
                }
            } catch let JSONerror {
                print("error decoding JSON", JSONerror)
            }
            
            }.resume()
    }
    
    @objc func refreshTableViewLogic() {
        let refreshDelay = DispatchTime.now() + .milliseconds(500)
        DispatchQueue.main.asyncAfter(deadline: refreshDelay) {
            self.loadItems()
            self.refreshTableView.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Protocols
    
    func addToBasket(item_id: String, multi: String, price: String) {
        _ = addSingleItemOrGoToMultiVC(item_id: item_id, multi: multi, price: price)
    }
    
    // return true if multi item, else false if item added to basket
    func addSingleItemOrGoToMultiVC(item_id: String, multi: String, price: String) -> Bool {
        if(multi == "Yes") {
            self.item_id = item_id
            self.performSegue(withIdentifier: "showMultiItems", sender:self)
            return true
        } else {
            let prevVal = BasketArrays.totalPriceSingle[item_id]
            
            if(prevVal == nil) {
                BasketArrays.totalPriceSingle.updateValue(Double(price)!, forKey: item_id)
            } else {
                let newVal = prevVal! + Double(price)!
                BasketArrays.totalPriceSingle.updateValue(newVal, forKey: item_id)
            }
            
            if let count = BasketArrays.singleItems[item_id] {
                BasketArrays.singleItems.updateValue(count + 1, forKey: item_id)
            } else {
                BasketArrays.singleItems.updateValue(1, forKey: item_id)
            }
            
            let alertController = UIAlertController(title: "Success",
                                                    message: "Item added to basket",
                                                    preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                
            })
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
            
            _ = calculateTitleOfBasketButton()
            return false
        }
    }
}
