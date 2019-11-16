//
//  DealItemsChoicesTableViewController.swift
//  prototype
//
//  Created by James Liscombe on 08/10/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

protocol DealItemsChoicesTableViewControllerProtocol {
    func choiceMade(viewController: DealItemsChoicesTableViewController)
}

class DealItemsChoicesTableViewController: UITableViewController {
    
    var section = String()
    var dealID = String()
    let dispatchGroupLoadDealItems = DispatchGroup()
    var dealItems = [DealItemsModel]()
    var delegate: DealItemsChoicesTableViewControllerProtocol!
    var decision = String()

    override func viewDidLoad() {
        self.loadDealItems()
        if !Reachability.isConnectedToNetwork(){
            print("Internet Connection not Available")
            noInternetConnection()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = UIImageView(image: UIImage(named: "Background"))
        
        let dealItemsChoicesTableViewCellNib = UINib(nibName: "DealItemsChoicesTableViewCell", bundle: nil)
        tableView.register(dealItemsChoicesTableViewCellNib, forCellReuseIdentifier: "DealItemsChoicesTableViewCell")
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _ = calculateTitleOfBasketButton()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dealItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dealItemsChoicesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DealItemsChoicesTableViewCell", for: indexPath) as! DealItemsChoicesTableViewCell
        dealItemsChoicesTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
        dealItemsChoicesTableViewCell.dealItemChoiceLabel.text = dealItems[indexPath.row].item
        return dealItemsChoicesTableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.decision = dealItems[indexPath.row].item!
        self.navigationController?.popViewController(animated: true)
        delegate.choiceMade(viewController: self)
    }
    
    //MARK: - Objc functions
        @objc func loadDealItems() {
    
            let dealId = self.dealID.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            let section = self.section.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    
            let urlApi = Constants.baseURLString+dealId!+"/"+section!
    
            guard let url = URL(string: urlApi) else {return}
    
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {return}
                do {
                    self.dispatchGroupLoadDealItems.enter()
                    self.dealItems = try JSONDecoder().decode([DealItemsModel].self, from: data)
                    self.dispatchGroupLoadDealItems.leave()
    
                    self.dispatchGroupLoadDealItems.notify(queue: .main) {
                        self.tableView.reloadData()
                    }
                } catch let JSONerror {
                    print("error decoding JSON", JSONerror)
                }
    
                }.resume()
        }

}
