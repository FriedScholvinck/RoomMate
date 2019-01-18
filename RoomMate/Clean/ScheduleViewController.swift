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
    var tasks: [[String]] = []


    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = CurrentUser.user.house!
        getResidents()
        getTasks()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func getTasks() {
        tasks = [(CurrentUser.houses[CurrentUser.user.house!]?.tasks)!]

        // set empty tasks if not enough
        while tasks[0].count < residents.count {
            tasks[0].append("")
        }
        
        divideTasks()
    }
    
    /// create moved lists of tasks
    func divideTasks() {
        for week in 0...4 {
            var movedTasks = Array(tasks[week][1...])
            movedTasks.append(tasks[week][0])
            tasks.append(movedTasks)
        }
    }
    
    func getResidents() {
        for memberID in (CurrentUser.houses[CurrentUser.user.house!]?.residents)! {
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
        cell.detailTextLabel?.text = String(tasks[segmentControl.selectedSegmentIndex][indexPath.row])
    }
}
