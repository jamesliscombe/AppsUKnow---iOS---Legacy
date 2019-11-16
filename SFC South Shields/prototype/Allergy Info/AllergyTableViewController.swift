//
//  AllergyTableViewController.swift
//  prototype
//
//  Created by James Liscombe on 11/09/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import UIKit

class AllergyTableViewController: UITableViewController {

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        if !Reachability.isConnectedToNetwork(){
            print("Internet Connection not Available!")
            noInternetConnection()
        }
        
        let allergyInfoTableViewCellNib = UINib(nibName: "AllergyInfoTableViewCell", bundle: nil)
        tableView.register(allergyInfoTableViewCellNib, forCellReuseIdentifier: "AllergyInfoTableViewCell")
        
        //tableView.backgroundView = UIImageView(image: UIImage(named: "Background"))
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let allergyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AllergyInfoTableViewCell", for: indexPath) as! AllergyInfoTableViewCell
        allergyInfoTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
        return allergyInfoTableViewCell
    }

}
