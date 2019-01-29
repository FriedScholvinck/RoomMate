//
//  YouHouseViewController.swift
//  RoomMate
//
//  Created by Fried on 09/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  This view controller contains a table view with all the residents of the house of the current user.

import UIKit
import Firebase

class YourHouseViewController: UITableViewController {
    let ref = Database.database().reference()
    var residents: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getResidentNames()
        navigationItem.title = CurrentUser.user.house
    }
    
    /// get names of room mates
    func getResidentNames() {
        residents = []
        for memberID in CurrentUser.residents {
            residents.append((CurrentUser.users[memberID]?.name)!)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    /// helper function for setting table view
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        cell.textLabel?.text = residents[indexPath.row]
    }
}
