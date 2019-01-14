//
//  ViewController.swift
//  RoomMate
//
//  Created by Fried on 07/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  View Controller for logging in and register via Google Firebase

import UIKit
import FirebaseUI
import FirebaseDatabase

class LogInViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.applyDesign()
    }

    /// prepare for Firebase login and register
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        
        // get default auth UI object
        let authUI = FUIAuth.defaultAuthUI()
        guard authUI != nil else {
            return
        }
        authUI?.delegate = self
        
        // get reference to the auth UI view controller
        let authViewController = authUI!.authViewController()
        
        // show  Firebase login controller
        present(authViewController, animated: true, completion: nil)
    }
    
    
}

extension LogInViewController: FUIAuthDelegate {
    
    /// log in user
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error != nil {
            return
        }
        
        // get user info to global variable
        CurrentUser.user.id = (authDataResult?.user.uid)!
        CurrentUser.user.name = (authDataResult?.user.displayName)!
        CurrentUser.user.email = (authDataResult?.user.email)!
        
        // if new user, create account online
        if (authDataResult?.additionalUserInfo?.isNewUser)! {
            DataController.shared.createNewUser(id: CurrentUser.user.id, name: CurrentUser.user.name, email: CurrentUser.user.email)
        }
        
        performSegue(withIdentifier: "goHome", sender: self)
    }
}

// green round label design
extension UILabel {
    func applyDesign() {
        self.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:1.0)
        self.layer.cornerRadius = self.frame.height / 2
        self.textColor = UIColor.white
    }
}

// green round button design
extension UIButton {
    func applyDesign() {
        self.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:1.0)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.white, for: .normal)
    }
}
