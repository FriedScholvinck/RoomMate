//
//  ViewController.swift
//  RoomMate
//
//  Created by Fried on 07/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit
import FirebaseUI

class LogInViewController: UIViewController {
//    var currentUID: String

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.applyDesign()
    }

    @IBAction func logInButtonTapped(_ sender: UIButton) {
        
        // get default auth UI object
        let authUI = FUIAuth.defaultAuthUI()
        guard authUI != nil else {
            return
        }
        
        // set ourselves as the delegate
        authUI?.delegate = self
        
        // get reference to the auth UI view controller
        let authViewController = authUI!.authViewController()
        
        // show controller
        present(authViewController, animated: true, completion: nil)
    }
    
}

extension LogInViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error != nil {
            return
        }
        
        // get user uid
//        currentUID = authDataResult?.user.uidr
        
        performSegue(withIdentifier: "goHome", sender: self)
    }
}

extension UILabel {
    func applyDesign() {
        self.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:1.0)
        self.layer.cornerRadius = self.frame.height / 2
        self.textColor = UIColor.white
    }
}

extension UIButton {
    func applyDesign() {
        self.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:1.0)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.white, for: .normal)
    }
}
