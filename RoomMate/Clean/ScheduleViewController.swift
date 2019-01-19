//
//  ScheduleViewController.swift
//  RoomMate
//
//  Created by Fried on 09/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit
import Firebase

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let ref = Database.database().reference()
    var residents: [String] = []
//    var week: Int = 0

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = CurrentUser.user.house!
        getResidentNames()
        setWeekSegments()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func setWeekSegments() {
        for week in 0...4 {
            segmentControl.setTitle(String(CurrentUser.houses[CurrentUser.user.house!]!.firstWeek + week), forSegmentAt: week)
        }
        segmentControl.selectedSegmentIndex = getCurrentWeek() - CurrentUser.houses[CurrentUser.user.house!]!.firstWeek
    }
    
    
    func getResidentNames() {
        for memberID in CurrentUser.residents {
            residents.append((CurrentUser.users[memberID]?.name)!)
        }
    }
    
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
    
    /// set cell text and image
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        cell.textLabel?.text = residents[indexPath.row]
        cell.detailTextLabel?.text = String(CurrentUser.tasks[segmentControl.selectedSegmentIndex][indexPath.row])
    }
}
