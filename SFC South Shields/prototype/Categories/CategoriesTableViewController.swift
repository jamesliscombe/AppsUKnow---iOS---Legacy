//
//  categoriesTableView.swift
//  prototype
//
//  Created by James Liscombe on 05/07/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    //MARK: - Properties and computed variables
    var categories = [CategoryModel]()
    var deliveryCharges: [DeliveryChargeModel]?
    var keysModel: [KeysModel]?
    var timesModel: [AverageTimesModel]?
    lazy var selectedCategoryID = Int()
    lazy var selectedCategoryName = String()
    lazy var selectedCategoryDescription = String()
    let dispatchGroupLoadCategories = DispatchGroup()
    
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
        startActivityIndicator()
        setNavBarColour()
        
        if (!Reachability.isConnectedToNetwork()){
            print("Internet Connection not Available!")
            noInternetConnection()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = UIImageView(image: UIImage(named: "Background"))
        tableView.refreshControl = refreshTableView
        
        let restaurantInfoTableViewCellNib = UINib(nibName: "RestaurantInfoTableViewCell", bundle: nil)
        tableView.register(restaurantInfoTableViewCellNib, forCellReuseIdentifier: "RestaurantInfoTableViewCell")
        
        let categoryTableViewCellNib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        tableView.register(categoryTableViewCellNib, forCellReuseIdentifier: "CategoryTableViewCell")
        
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if(categories.count == 0) {
            return 0
        } else {
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else if (section == 1) {
            return 1
        } else {
            return categories.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let restaurantInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RestaurantInfoTableViewCell", for: indexPath) as! RestaurantInfoTableViewCell
            restaurantInfoTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
            let deliveryChargeValue: String = deliveryCharges?[3].value ?? ""
            let minDeliveryValue: String = deliveryCharges?[2].value ?? ""
            BasketArrays.minOrder = minDeliveryValue
            BasketArrays.deliveryCharge = deliveryChargeValue
            restaurantInfoTableViewCell.restaurantDeliveryLabel.text = "Delivery: £"+deliveryChargeValue+"          Minimum: £"+minDeliveryValue
            
            return restaurantInfoTableViewCell
            
        } else if indexPath.section == 1 {
            let dealTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
            dealTableViewCell.categoryNameLabel.text = "DEALS"
            dealTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
            return dealTableViewCell
        } else {
            let categoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
            categoryTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
            categoryTableViewCell.categoryNameLabel.text = categories[indexPath.row].name
            return categoryTableViewCell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let dealsTableViewController = storyboard?.instantiateViewController(withIdentifier: "DealsTableViewController") as! DealsTableViewController
            self.navigationController?.pushViewController(dealsTableViewController, animated: true)
        } else if(indexPath.section == 2) {
            self.selectedCategoryID = categories[indexPath.row].ID!
            self.selectedCategoryName = categories[indexPath.row].name!
            self.selectedCategoryDescription = categories[indexPath.row].description!
            performSegue(withIdentifier: "showItemsInCategory", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showItemsInCategory") {
            let itemsTableViewController = segue.destination as! ItemsTableViewController
            itemsTableViewController.selectedCategoryID = self.selectedCategoryID
            itemsTableViewController.selectedCategoryName = self.selectedCategoryName
            itemsTableViewController.selectedCategoryDescription = self.selectedCategoryDescription
            itemsTableViewController.startActivityIndicator()
            itemsTableViewController.show(self, sender: nil)
        }
    }
    
    //MARK: - Custom functions
    func startActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingTableView.center = self.tableView.center
            self.loadingTableView.style = UIActivityIndicatorView.Style.gray
            self.tableView.addSubview(self.loadingTableView)
            self.loadingTableView.startAnimating()
            self.loadCategories()
            self.loadDeliveryCharges()
            self.loadPublishableKey()
            self.loadAvgTimes()
            self.loadingTableView.stopAnimating()
        }
    }
    
    //MARK: - Objc functions
    @objc func loadCategories() {
        let urlApi = Constants.baseURLString+"wp-json/appsuknow/v1/categories"
        
        guard let url = URL(string: urlApi) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            do {
                self.dispatchGroupLoadCategories.enter()
                self.categories = try JSONDecoder().decode([CategoryModel].self, from: data)
                self.dispatchGroupLoadCategories.leave()
                
                self.dispatchGroupLoadCategories.notify(queue: .main) {
                    self.tableView.reloadData()
                }
            } catch let JSONerror {
                print("error decoding JSON", JSONerror)
            }
            
            }.resume()
    }
    
    @objc func loadDeliveryCharges() {
        let urlApi = Constants.baseURLString+"wp-json/appsuknow/v1/settings"
        
        guard let url = URL(string: urlApi) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(NSString(data: data!, encoding:String.Encoding.utf8.rawValue)!)
            guard let data = data else {return}
            do {
                self.dispatchGroupLoadCategories.enter()
                self.deliveryCharges = try JSONDecoder().decode([DeliveryChargeModel].self, from: data)
                self.dispatchGroupLoadCategories.leave()
                
                self.dispatchGroupLoadCategories.notify(queue: .main) {
                    self.tableView.reloadData()
                }
            } catch let JSONerror {
                print("error decoding JSON", JSONerror)
            }
            
            }.resume()
    }
    
    @objc func loadPublishableKey() {
        let urlApi = Constants.baseURLString+"wp-json/appsuknow/v1/stripe_key"
        
        guard let url = URL(string: urlApi) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(NSString(data: data!, encoding:String.Encoding.utf8.rawValue)!)
            guard let data = data else {return}
            do {
                self.dispatchGroupLoadCategories.enter()
                self.keysModel = try JSONDecoder().decode([KeysModel].self, from: data)
                self.dispatchGroupLoadCategories.leave()
                
                self.dispatchGroupLoadCategories.notify(queue: .main) {
                    Constants.publishableKey = self.keysModel?[0].stripe_publishable_key
                    self.tableView.reloadData()
                }
            } catch let JSONerror {
                print("error decoding JSON", JSONerror)
            }
            
            }.resume()
    }
    
    @objc func loadAvgTimes() {
        let urlApi = Constants.baseURLString+"wp-json/appsuknow/v1/settings"
        
        guard let url = URL(string: urlApi) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            do {
                self.dispatchGroupLoadCategories.enter()
                self.timesModel = try JSONDecoder().decode([AverageTimesModel].self, from: data)
                self.dispatchGroupLoadCategories.leave()
                
                self.dispatchGroupLoadCategories.notify(queue: .main) {
                    Constants.avgDeliveryTime = self.timesModel?[1].value
                    Constants.avgCollectionTime = self.timesModel?[0].value
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
            self.loadCategories()
            self.loadDeliveryCharges()
            self.loadPublishableKey()
            self.loadAvgTimes()
            self.refreshTableView.endRefreshing()
            self.tableView.reloadData()
        }
    }
}
