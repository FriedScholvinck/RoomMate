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
    
    @IBOutlet weak var yourTaskLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskLabel.applyDesign()
        updateUI()
    }
    
    func updateUI() {
        getData {
            self.taskLabel.text = "   \(CurrentUser.user.currentTask)"
        }
    }
    
    /// get data from database again
    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        updateUI()
    }
    
    
    
}
