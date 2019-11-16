//
//  SettingsTableViewController.swift
//  AppsUKnow Demo
//
//  Created by James Liscombe on 03/01/2019.
//  Copyright © 2019 appsuknow. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = UIImageView(image: UIImage(named: "Background"))
        navigationItem.title = "Settings"
        setNavBarColour()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        
        headerView.backgroundColor = UIColor.clear
        
        return headerView
    }

}
