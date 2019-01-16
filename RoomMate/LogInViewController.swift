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
    let ref = Database.database().reference()
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

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
            // create new user
            ref.child("users/\(CurrentUser.user.id)").setValue(["name": CurrentUser.user.name, "email": CurrentUser.user.email, "drinks": 0])
            CurrentUser.ref = ref.child("users/\(CurrentUser.user.id)")

        }
        
        performSegue(withIdentifier: "goHome", sender: self)
    }
}

// this extension makes it able for any view controller to create a loading alert, which will be dismissed as the data request is completed - makes it impossible for the user to continue while the data is requested and shows 'Please wait...' - accessible via every viewcontroller, calling getData()
extension UIViewController {
    
    func getData() {
//        let alert = createLoadingAlert()
        DataController.shared.getData {
//            alert.dismiss(animated: false, completion: nil)
        }
    }
    
    func createLoadingAlert() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        return alert
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
