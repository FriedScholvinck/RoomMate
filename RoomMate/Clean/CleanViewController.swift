//
//  CleanViewController.swift
//  RoomMate
//
//  Created by Fried on 07/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit
import Firebase

class CleanViewController: UIViewController {
    let ref = Database.database().reference()

    @IBOutlet weak var yourScheduleButton: UIButton!
    @IBOutlet weak var createScheduleButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yourScheduleButton.applyDesign()
        createScheduleButton.applyDesign()
        
        
    }
    
    func updateUI() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if CurrentUser.user.house == nil {
            yourScheduleButton.isEnabled = false
            yourScheduleButton.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:0.5)
            createScheduleButton.isEnabled = false
            createScheduleButton.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:0.5)
            createAlert(title: "You're not yet in a house.", message: "Join or create one at 'Profile'")
        } else {
            if let home = CurrentUser.houses[CurrentUser.user.house!] {
                // get your schedule
            }
        }
        updateUI()
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    

}
