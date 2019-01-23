//
//  AppManager.swift
//  RoomMate
//
//  Created by Fried on 10/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  This class helps AppContainerViewController to find out whether the user has already logged in, and presents either the 'Log In' or 'Home' view controller

import UIKit
import Firebase

class AppManager {
    let ref = Database.database().reference()
    static let shared = AppManager()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var appContainer: AppContainerViewController!
    private init() { }
    
    /// check if user has already logged in
    func showApp() {
        var viewController: UIViewController
        
        // set viewController to 'Log In' or 'Home'
        if Auth.auth().currentUser == nil {
            viewController = storyboard.instantiateViewController(withIdentifier: "LogInViewController")
        } else {
            viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
            
            // set current user variables
            CurrentUser.user.id = (Auth.auth().currentUser?.uid)!
            CurrentUser.user.name = (Auth.auth().currentUser?.displayName)!
            CurrentUser.user.email = (Auth.auth().currentUser?.email)!
            CurrentUser.ref = ref.child("users").child(CurrentUser.user.id)
        }
        
        appContainer.present(viewController, animated: true, completion: nil)
    }
    
    /// logout user
    func logout() {
        try! Auth.auth().signOut()
        appContainer.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
}
