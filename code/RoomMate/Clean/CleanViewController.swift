//
//  CleanViewController.swift
//  RoomMate
//
//  Created by Fried on 07/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  This view controller holds the cleaning schedule and a button to create a new schedule. The weekly shifting schedule is as long as the amount of residents in the house. It is controlled by a segment control, which if of the same length.

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
    }
    
    /// clean table view first, otherwise Indexpath gets too big
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        residents = []
        tableView.reloadData()
        getAllData {
            self.updateUI()
        }
    }
    
    /// update user interface only if user is in house, else alert user there not in a house yet
    func updateUI() {
        if CurrentUser.user.house != nil {
            getResidentNames()
            setSegmentControl()
            tableView.reloadData()
            createScheduleButton.isEnabled = true
            createScheduleButton.backgroundColor = UIColor(red: 0.22, green: 0.57, blue: 0.47, alpha: 1.0)
        } else {
            createScheduleButton.isEnabled = false
            createScheduleButton.backgroundColor = UIColor(red: 0.22, green: 0.57, blue: 0.47, alpha: 0.5)
            createAlert(title: "You're not yet in a house.", message: "Join or create one at 'Profile'", pop: false)
        }
    }
    
    /// set variable residents with names for table view
    func getResidentNames() {
        for memberID in CurrentUser.residents {
            residents.append((CurrentUser.users[memberID]?.name)!)
        }
    }
    
    /// set segment control size to amount of residents and add week numbers as titles
    func setSegmentControl() {
        segmentControl.removeAllSegments()
        
        // insert as many segments as residents
        for week in 0...residents.count - 1 {
            
            // if cleaning schedule exceeds last week in year, stop adding segments
            if CurrentUser.houses[CurrentUser.user.house!]!.firstWeek + week > 52 {
                break
            }
            
            // make segment with corresponding title
            segmentControl.insertSegment(withTitle: String(CurrentUser.houses[CurrentUser.user.house!]!.firstWeek + week), at: week, animated: true)
        }
        
        // make current week selected when view appears
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
    
    /// helper function for setting table view
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        cell.textLabel?.text = residents[indexPath.row]
        
        // don't show detail if there are no tasks
        if CurrentUser.tasks.count > 0 {
            cell.detailTextLabel?.text = String(CurrentUser.tasks[segmentControl.selectedSegmentIndex][indexPath.row])
        }
    }
}
