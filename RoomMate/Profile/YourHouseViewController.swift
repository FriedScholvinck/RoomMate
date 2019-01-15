//
//  YouHouseViewController.swift
//  RoomMate
//
//  Created by Fried on 09/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit
import Firebase

class YourHouseViewController: UITableViewController {
    let ref = Database.database().reference()
    var residents: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getResidents()

    }
    
    
    func getResidents() {
        for memberID in (CurrentUser.houses[CurrentUser.user.house!]?.residents)! {
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
    
    /// set cell text
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        cell.textLabel?.text = residents[indexPath.row]
    }

}
