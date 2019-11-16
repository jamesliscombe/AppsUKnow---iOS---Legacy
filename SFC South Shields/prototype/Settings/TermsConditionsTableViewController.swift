//
//  TermsConditionsTableViewController.swift
//  AppsUKnow Demo
//
//  Created by James Liscombe on 07/01/2019.
//  Copyright © 2019 appsuknow. All rights reserved.
//

import UIKit

class TermsConditionsTableViewController: UITableViewController {

    override func viewDidLoad() {
        let termsConditionsTableViewCellNib = UINib(nibName: "TermsConditionsTableViewCell", bundle: nil)
        tableView.register(termsConditionsTableViewCellNib, forCellReuseIdentifier: "TermsConditionsTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1000
        tableView.tableFooterView = UIView()
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let termsConditionsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TermsConditionsTableViewCell", for: indexPath) as! TermsConditionsTableViewCell
        termsConditionsTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
        return termsConditionsTableViewCell
    }

}
