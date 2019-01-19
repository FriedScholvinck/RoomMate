//
//  HomeViewController.swift
//  RoomMate
//
//  Created by Fried on 07/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  

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
        getData {
            self.updateUI()
        }
    }
    
    func updateUI() {
        setCurrentTask()
        dinnerSwitch.setOn(CurrentUser.user.dinner, animated: true)
    }
    
    ///
    @IBAction func dinnerSwitchChanged(_ sender: UISwitch) {
        CurrentUser.ref.child("dinner").setValue(dinnerSwitch.isOn)
        CurrentUser.users[CurrentUser.user.id]!.dinner = dinnerSwitch.isOn
    }
    
    /// set this weeks task in label
    func setCurrentTask() {
        if let houseName = CurrentUser.user.house {
            if let house = CurrentUser.houses[houseName] {
                let residentIndex = house.residents.firstIndex(of: CurrentUser.user.id)
                let weekIndex = getCurrentWeek() - house.firstWeek
                currentTask = CurrentUser.tasks[weekIndex][residentIndex!]
                taskLabel.text = currentTask
            }
        }
    }
    
    /// get data from database again
    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        getData {
            self.updateUI()
        }
    }
}
