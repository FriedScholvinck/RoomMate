//
//  ViewController.swift
//  RoomMate
//
//  Created by Fried on 07/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  View Controller for log in and register via Google Firebase (shows AuthViewController by Google Firebase)

import UIKit
import FirebaseUI
import FirebaseDatabase


class LogInViewController: UIViewController, FUIAuthDelegate {
    let ref = Database.database().reference()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
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
            // create new user
            ref.child("users/\(CurrentUser.user.id)").setValue(["name": CurrentUser.user.name, "email": CurrentUser.user.email, "drinks": 0, "drinksToBuy": 0, "dinner": false])
            CurrentUser.ref = ref.child("users/\(CurrentUser.user.id)")
            
        }
        
        performSegue(withIdentifier: "goHome", sender: self)
    }
}
