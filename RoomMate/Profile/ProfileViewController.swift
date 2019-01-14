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

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var houseButton: UIButton!
    @IBOutlet weak var joinHouseButton: UIButton!
    @IBOutlet weak var createHouseButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        joinHouseButton.applyDesign()
        createHouseButton.applyDesign()
        nameLabel.text = CurrentUser.user.name
        emailLabel.text = CurrentUser.user.email
        houseButton.setTitle(CurrentUser.user.house, for: .normal)
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        AppManager.shared.logout()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
