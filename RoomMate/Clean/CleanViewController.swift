//
//  CleanViewController.swift
//  RoomMate
//
//  Created by Fried on 07/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit
import Firebase

class CleanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let ref = Database.database().reference()
    var residents: [String] = []
    
    @IBOutlet weak var createScheduleButton: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        createScheduleButton.applyDesign()
        getData {
            self.updateUI()
        }
    }

    ///
    func updateUI() {
        if CurrentUser.user.house != nil {
            getResidentNames()
            setWeekSegments()
            tableView.reloadData()
            createScheduleButton.isEnabled = true
            createScheduleButton.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:1.0)
        } else {
            createScheduleButton.isEnabled = false
            createScheduleButton.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:0.5)
            createAlert(title: "You're not yet in a house.", message: "Join or create one at 'Profile'")
        }
    }
    
    /// set variable with names for table view
    func getResidentNames() {
        for memberID in CurrentUser.residents {
            residents.append((CurrentUser.users[memberID]?.name)!)
        }
    }
    
    /// set segment title for scheduled weeks
    func setWeekSegments() {
        for week in 0...4 {
            segmentControl.setTitle(String(CurrentUser.houses[CurrentUser.user.house!]!.firstWeek + week), forSegmentAt: week)
        }
        segmentControl.selectedSegmentIndex = getCurrentWeek() - CurrentUser.houses[CurrentUser.user.house!]!.firstWeek
    }
    
    /// reload data in table view
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CleanCell", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        cell.textLabel?.text = residents[indexPath.row]
        cell.detailTextLabel?.text = String(CurrentUser.tasks[segmentControl.selectedSegmentIndex][indexPath.row])
    }
}
