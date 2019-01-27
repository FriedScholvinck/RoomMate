//
//  ProfileViewController.swift
//  RoomMate
//
//  Created by Fried on 10/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  This view controller contains user information and buttons to choose or create a house a house.

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    let ref = Database.database().reference()
    
    @IBOutlet weak var houseView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var houseButton: UIButton!
    @IBOutlet weak var joinHouseButton: UIButton!
    @IBOutlet weak var createHouseButton: UIButton!
    
    /// set design around labels with user info and fill name an email
    override func viewDidLoad() {
        super.viewDidLoad()
        joinHouseButton.applyDesign()
        createHouseButton.applyDesign()
        nameView.addBorder()
        emailView.addBorder()
        houseView.addBorder()
        nameLabel.text = CurrentUser.user.name
        emailLabel.text = CurrentUser.user.email
    }
    
    /// update view with new data
    override func viewWillAppear(_ animated: Bool) {
        getAllData {
            self.updateUI()
        }
    }
    
    /// set house button if user has house
    func updateUI() {
        if CurrentUser.user.house != nil {
            houseButton.isEnabled = true
        } else {
            houseButton.isEnabled = false
            
        }
        houseButton.setTitle(CurrentUser.user.house, for: .normal)
    }
    
    /// logout user, present login view controller
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        CurrentUser.user = User()
        AppManager.shared.logout()
    }
}
