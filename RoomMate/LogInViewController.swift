//
//  ViewController.swift
//  RoomMate
//
//  Created by Fried on 07/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  View Controller for log in and register via Google Firebase (shows AuthViewController by Google Firebase)
//  Extensions for ViewControllers, buttons and labels below

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
            ref.child("users/\(CurrentUser.user.id)").setValue(["name": CurrentUser.user.name, "email": CurrentUser.user.email, "drinks": 0, "drinksBehind": 0, "dinner": false])
            CurrentUser.ref = ref.child("users/\(CurrentUser.user.id)")
            
        }
        
        performSegue(withIdentifier: "goHome", sender: self)
    }
}

// call getData from every view controller
extension UIViewController {
    
    /// get data from firebase and store in global variables
    func getData(completion: @escaping () -> Void) {
        DataController.shared.getData {
            
            // set house info if available
            DispatchQueue.main.async {
                if let houseName = CurrentUser.user.house {
                    if let house = CurrentUser.houses[houseName] {
                        
                        CurrentUser.residents = house.residents
                        self.setTasks()
                    }
                }
                completion()
            }
        }
    }
    
    /// set current cleaning schedule
    func setTasks() {
        CurrentUser.tasks = [(CurrentUser.houses[CurrentUser.user.house!]?.tasks)!]
        
        // set empty tasks if not enough
        while CurrentUser.tasks[0].count < CurrentUser.residents.count {
            CurrentUser.tasks[0].append("")
        }
        
        divideTasks()
    }
    
    /// create moved lists of tasks
    func divideTasks() {
        for week in 0...CurrentUser.residents.count - 1 {
            var movedTasks = Array(CurrentUser.tasks[week][1...])
            movedTasks.append(CurrentUser.tasks[week][0])
            CurrentUser.tasks.append(movedTasks)
        }
    }
    
    /// get current week number in year
    func getCurrentWeek() -> Int {
        let calendar = NSCalendar.current
        let component = calendar.component(.weekOfYear, from: Date())
        return component
    }
    
    /// alert user if not yet in house (for clean and drinks overview)
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func createPopAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
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
