//
//  ProfileViewController.swift
//  RoomMate
//
//  Created by Fried on 10/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    let ref = Database.database().reference()

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var houseButton: UIButton!
    @IBOutlet weak var joinHouseButton: UIButton!
    @IBOutlet weak var createHouseButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if CurrentUser.user.house != nil {
            houseButton.isEnabled = true
        } else {
            houseButton.isEnabled = false
        }
        houseButton.setTitle(CurrentUser.user.house, for: .normal)
    }
    
    func updateUI() {
        joinHouseButton.applyDesign()
        createHouseButton.applyDesign()
        nameLabel.text = CurrentUser.user.name
        emailLabel.text = CurrentUser.user.email
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        CurrentUser.user = User()
        AppManager.shared.logout()
    }
    
}
