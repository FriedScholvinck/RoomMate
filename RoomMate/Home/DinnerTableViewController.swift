//
//  DinnerTableViewController.swift
//  RoomMate
//
//  Created by Fried on 19/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  Overview of all Room Mates and if they eat at home tonight

import UIKit
import Firebase

class DinnerTableViewController: UITableViewController {
    let ref = Database.database().reference()
    var residents: [String] = []
    var dinner: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData {
            self.getResidentNames()
            self.getDinnerDetail()
            self.tableView.reloadData()
        }
    }

    /// assign names of room mates
    func getResidentNames() {
        residents = []
        for memberID in CurrentUser.residents {
            residents.append((CurrentUser.users[memberID]?.name)!)
        }
    }
    
    /// assign whether room mates will eat at home tonight
    func getDinnerDetail() {
        for resident in CurrentUser.residents {
            if (CurrentUser.users[resident]?.dinner)! {
                dinner.append("✔️")
            } else {
                dinner.append("")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DinnerCell", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        cell.textLabel?.text = residents[indexPath.row]
        cell.detailTextLabel?.text = dinner[indexPath.row]
    }
}
