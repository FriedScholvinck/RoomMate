//
//  AppManager.swift
//  RoomMate
//
//  Created by Fried on 10/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit
import Firebase

class AppManager {
    
    static let shared = AppManager()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var appContainer: AppContainerViewController!
    
    private init() { }
    
    /// check if user has already logged in
    func showApp() {
        var viewController: UIViewController
        
        if Auth.auth().currentUser == nil {
            viewController = storyboard.instantiateViewController(withIdentifier: "LogInViewController")
        } else {
            viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        }
        
        appContainer.present(viewController, animated: true, completion: nil)
    }
    
    /// logout user
    func logout() {
        try! Auth.auth().signOut()
        appContainer.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
}
