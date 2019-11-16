//
//  PrivacyPolicyTableViewController.swift
//  AppsUKnow Demo
//
//  Created by James Liscombe on 04/01/2019.
//  Copyright © 2019 appsuknow. All rights reserved.
//

import UIKit

class PrivacyPolicyTableViewController: UITableViewController {

    override func viewDidLoad() {
        let privacyPolicyTableViewCellNib = UINib(nibName: "PrivacyPolicyTableViewCell", bundle: nil)
        tableView.register(privacyPolicyTableViewCellNib, forCellReuseIdentifier: "PrivacyPolicyTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1000
        tableView.tableFooterView = UIView()
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let privacyPolicyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PrivacyPolicyTableViewCell", for: indexPath) as! PrivacyPolicyTableViewCell
        privacyPolicyTableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
        return privacyPolicyTableViewCell
    }

}
