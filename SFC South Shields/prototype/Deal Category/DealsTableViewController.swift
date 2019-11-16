//
//  DealsTableViewController.swift
//  prototype
//
//  Created by James Liscombe on 04/10/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class DealsTableViewController: UITableViewController {
    
    //MARK: - Properties and computed variables
    let dispatchGroupLoadDeals = DispatchGroup()
    var deals = [DealsModel]()
    var selectedDeal = String()
    var selectedDealSections = Int()
    var selectedDealId = String()
    var selectedDealPrice = Double()
    var selectedDealDescription = String()
    
    lazy var refreshTableView: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshTableViewLogic), for: .valueChanged)
        return refreshControl
    }()
    
    //MARK: - TableView functions (overrides)
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _ = calculateTitleOfBasketButton()
    }
    
    override func viewDidLoad() {
        self.loadDeals()
        
        if !Reachability.isConnectedToNetwork(){
            print("Internet Connection not Available!")
            noInternetConnection()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = UIImageView(image: UIImage(named: "Background"))
        tableView.refreshControl = refreshTableView
        
        let dealTableViewCellNib = UINib(nibName: "DealTableViewCell", bundle: nil)
        tableView.register(dealTableViewCellNib, forCellReuseIdentifier: "DealTableViewCell")
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
        
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dealTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DealTableViewCell", for: indexPath) as! DealTableViewCell
        dealTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
        dealTableViewCell.dealNameLabel.text = deals[indexPath.row].name
        dealTableViewCell.dealPriceLabel.text = "£"+deals[indexPath.row].price!
        dealTableViewCell.dealDescriptionLabel.text = deals[indexPath.row].description
        
//        if(deals[indexPath.row].description?.count == 0) {
//            dealTableViewCell.dealDescriptionLabel.isHidden = true
//        } else {
//            dealTableViewCell.dealDescriptionLabel.text = deals[indexPath.row].description
//        }
        
        return dealTableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedDeal = deals[indexPath.row].name!
        self.selectedDealSections = deals[indexPath.row].num_sections!
        self.selectedDealId = String(deals[indexPath.row].deal_id!)
        self.selectedDealPrice = Double(deals[indexPath.row].price!)!
        self.selectedDealDescription = deals[indexPath.row].description!
        performSegue(withIdentifier: "showItemsInDeal", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showItemsInDeal") {
            let dealItemsTableViewController = segue.destination as! DealItemsTableViewController
            dealItemsTableViewController.selectedDeal = self.selectedDeal
            dealItemsTableViewController.selectedDealSections = self.selectedDealSections
            dealItemsTableViewController.selectedDealId = self.selectedDealId
            dealItemsTableViewController.selectedDealPrice = self.selectedDealPrice
            dealItemsTableViewController.selectedDealDescription = self.selectedDealDescription
            dealItemsTableViewController.show(self, sender: nil)
        }
    }
    
    //MARK: - Custom functions
    
    //MARK: - Objc functions
    @objc func refreshTableViewLogic() {
        let refreshDelay = DispatchTime.now() + .milliseconds(500)
        DispatchQueue.main.asyncAfter(deadline: refreshDelay) {
            self.refreshTableView.endRefreshing()
            self.loadDeals()
            self.tableView.reloadData()
        }
    }
    
    @objc func loadDeals() {
        let urlApi = Constants.baseURLString+"deals"
        
        guard let url = URL(string: urlApi) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            do {
                self.dispatchGroupLoadDeals.enter()
                self.deals = try JSONDecoder().decode([DealsModel].self, from: data)
                self.dispatchGroupLoadDeals.leave()
                
                self.dispatchGroupLoadDeals.notify(queue: .main) {
                    self.tableView.reloadData()
                }
            } catch let JSONerror {
                print("error decoding JSON", JSONerror)
            }
            
            }.resume()
    }

}
