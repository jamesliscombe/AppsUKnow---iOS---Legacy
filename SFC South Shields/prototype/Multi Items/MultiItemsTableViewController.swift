//
//  multiItemsTableViewController.swift
//  prototype
//
//  Created by James Liscombe on 18/07/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class MultiItemsTableViewController: UITableViewController, AddMultiItemWithDescriptionToBasketButtonProtocol {
    
    //MARK: - Properties and computer variables
    var multiItems = [MultiItemsModel]()
    lazy var item_id = String()
    let dispatchGroupLoadMultiItems = DispatchGroup()
    
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
        
        if (!Reachability.isConnectedToNetwork()){
            print("Internet Connection not Available!")
            noInternetConnection()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = UIImageView(image: UIImage(named: "Background"))
        tableView.refreshControl = refreshTableView
        
        let multiItemWithDescriptionTableViewCell = UINib(nibName: "MultiItemWithDescriptionTableViewCell", bundle: nil)
        tableView.register(multiItemWithDescriptionTableViewCell, forCellReuseIdentifier: "MultiItemWithDescriptionTableViewCell")
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView()
        
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return multiItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let multiItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MultiItemWithDescriptionTableViewCell", for: indexPath) as! multiItemWithDescriptionTableViewCell
        multiItemTableViewCell.delegate = self
        multiItemTableViewCell.item_id = String(multiItems[indexPath.row].ID!)
        multiItemTableViewCell.multiItemNameLabel.text = multiItems[indexPath.row].name!
        multiItemTableViewCell.multiItemDescriptionLabel.text = multiItems[indexPath.row].description!
        multiItemTableViewCell.multiItemPriceLabel.text = multiItems[indexPath.row].price!
        multiItemTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
        return multiItemTableViewCell
    }
    
    //MARK: - Custom functions
    func startActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingTableView.center = self.tableView.center
            self.loadingTableView.style = UIActivityIndicatorView.Style.gray
            self.tableView.addSubview(self.loadingTableView)
            self.loadingTableView.startAnimating()
            self.loadMultiItems()
            self.loadingTableView.stopAnimating()
        }
    }
    
    //MARK: - Objc functions
    @objc func loadMultiItems() {
        let urlApi = Constants.baseURLString+"wp-json/appsuknow/v1/item/lvl2/"+self.item_id
        
        print(urlApi)
        
        guard let url = URL(string: urlApi) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            do {
                self.dispatchGroupLoadMultiItems.enter()
                self.multiItems = try JSONDecoder().decode([MultiItemsModel].self, from: data)
                self.dispatchGroupLoadMultiItems.leave()
                
                self.dispatchGroupLoadMultiItems.notify(queue: .main) {
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
            self.loadMultiItems()
            self.refreshTableView.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Protocols
    func addToBasket(item_id: String, price: String) {
        let prevVal = BasketArrays.totalPriceMulti[item_id]
        
        if(prevVal == nil) {
            BasketArrays.totalPriceMulti.updateValue(Double(price)!, forKey: item_id)
        } else {
            let newVal = prevVal! + Double(price)!
            BasketArrays.totalPriceMulti.updateValue(newVal, forKey: item_id)
        }
        
        if let count = BasketArrays.multiItems[item_id] {
            BasketArrays.multiItems.updateValue(count + 1, forKey: item_id)
        } else {
            BasketArrays.multiItems.updateValue(1, forKey: item_id)
        }
        
        let alertController = UIAlertController(title: "Success",
                                                message: "Item added to basket",
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            
        })
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
        
        _ = calculateTitleOfBasketButton()
    }
    
}
