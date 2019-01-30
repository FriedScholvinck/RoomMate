//
//  Extenstions.swift
//  RoomMate
//
//  Created by Fried on 25/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  This file contains extensions for ViewControllers, buttons and labels

import UIKit


// this extension hold functions that are usefull and used by multiple view controllers
// getData() - calls setTasks(), divideTasks() - to get data from Firebase Database (and shows activity indicator)
// getCurrentWeek() - get the current week in the year
// createAlert() - create alert to notity user, pop-boolean: true = pop back to previous view controller
extension UIViewController {
    
    /// get data from firebase and store in global variables
    func getAllData(completion: @escaping () -> Void) {
        if DataController.shared.checkInternetConnection() {
            // show network indicator and make user unable to click on anything while getting data
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            // call DataController.swift to get data from Firebase Database
            DataController.shared.getUserAndHouseData {
                
                // set house info if available
                DispatchQueue.main.async {
                    if let houseName = CurrentUser.user.house {
                        if let house = CurrentUser.houses[houseName] {
                            
                            CurrentUser.residents = house.residents
                            self.setTasks()
                        }
                    }
                    
                    // stop indicator and complete data request
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    UIApplication.shared.endIgnoringInteractionEvents()
                    completion()
                }
            }
        } else {
            createAlert(title: "No Internet Connection Found", message: "Unable to load data", pop: false)
            return
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
    func createAlert(title: String, message: String, pop: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
            // show previous viewcontroller
            if pop {
                _ = self.navigationController?.popViewController(animated: true)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}


// label design with black border
extension UILabel {
    func applyDesign() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 1.0
    }
}


// green round button design
extension UIButton {
    func applyDesign() {
        self.backgroundColor = UIColor(red: 0.22, green: 0.57, blue: 0.47, alpha: 1.0)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.white, for: .normal)
    }
}


// view design with black border
extension UIView {
    func addBorder() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 1.0
    }
}
