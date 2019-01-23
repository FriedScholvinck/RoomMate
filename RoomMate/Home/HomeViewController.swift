//
//  HomeViewController.swift
//  RoomMate
//
//  Created by Fried on 07/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  Home View with your task for this week and navigation to dinner view

import UIKit
import Firebase

class HomeViewController: UIViewController {
    let ref = Database.database().reference()
    var currentTask = ""
    
    @IBOutlet weak var yourTaskLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var dinnerButton: UIButton!
    @IBOutlet weak var dinnerSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        taskLabel.applyDesign()
        dinnerButton.applyDesign()
        getAllData {
            self.updateUI()
        }
    }
    
    /// set interface again so make sure the view shows the most recent data 
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    /// show current task and dinner boolean
    func updateUI() {
        setCurrentTask()
        dinnerSwitch.setOn(CurrentUser.user.dinner, animated: true)
    }
    
    /// when user clicks on the dinner switch, change value in database and local
    @IBAction func dinnerSwitchChanged(_ sender: UISwitch) {
        CurrentUser.ref.child("dinner").setValue(dinnerSwitch.isOn)
        CurrentUser.users[CurrentUser.user.id]!.dinner = dinnerSwitch.isOn
    }
    
    /// set this weeks task in label, if any
    func setCurrentTask() {
        if let houseName = CurrentUser.user.house {
            if let house = CurrentUser.houses[houseName] {
                checkForEndOfYear(house: house)
            }
        }
    }
    
    /// if cleaning schedule exceeds last week in year, set first week to current week
    func checkForEndOfYear(house: House) {
        if getCurrentWeek() < house.firstWeek {
            
            ref.child("houses/\(CurrentUser.user.house!)/firstWeek").setValue(getCurrentWeek())
            getAllData {
                self.checkIfWeekInSchedule(house: CurrentUser.houses[CurrentUser.user.house!]!)
            }
        } else {
            checkIfWeekInSchedule(house: house)
        }
    
    }
    
    /// if this week is past the last week in the schedule, repeat schedule starting with current week
    func checkIfWeekInSchedule(house: House) {
        if getCurrentWeek() > house.firstWeek + (CurrentUser.residents.count - 1) {
            
            // set firstWeek variable to current week
            ref.child("houses/\(CurrentUser.user.house!)/firstWeek").setValue(getCurrentWeek())
            getAllData {
                self.showCurrentTask(house: CurrentUser.houses[CurrentUser.user.house!]!)
            }
        } else {
            showCurrentTask(house: house)
        }
    }
    
    /// helper for setCurrentTask(): set label with right task
    func showCurrentTask(house: House) {
        
        // get right index to get corresponding task
        let residentIndex = house.residents.firstIndex(of: CurrentUser.user.id)
        let weekIndex = getCurrentWeek() - house.firstWeek
        currentTask = CurrentUser.tasks[weekIndex][residentIndex!]
        taskLabel.text = currentTask
    }
    
    /// get data from database again and update interface
    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        getAllData {
            self.updateUI()
        }
    }
}
