//
//  DrinkViewController.swift
//  RoomMate
//
//  Created by Fried on 07/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  This view controller contains the functionality behind the drinking system in the app. The interface loads again when the view appears, so the most recent data is shown. When the user taps the 'Drink One' button, the database will be updated and the user will be notified if he/she needs to buy some beers.

import UIKit
import Firebase


class DrinkViewController: UIViewController {
    let ref = Database.database().reference()
    var totalDrinks = 0
    var yourDrinks = 0
    var drinksToBuy = 0
    
    @IBOutlet weak var getOverviewButton: UIBarButtonItem!
    @IBOutlet weak var changeDrinksButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var totalDrinksLabel: UILabel!
    @IBOutlet weak var drinksInStoreLabel: UILabel!
    @IBOutlet weak var drinkOneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeDrinksButton.applyDesign()
        drinkOneButton.applyDesign()
    }
    
    /// get all data to update interface with most recent data
    override func viewWillAppear(_ animated: Bool) {
        getAllData {
            
            // if user is not in a house, notify
            if CurrentUser.user.house == nil {
                self.changeDrinksButton.isEnabled = false
                self.changeDrinksButton.backgroundColor = UIColor(red: 0.22, green: 0.57, blue: 0.47, alpha: 0.5)
                self.getOverviewButton.isEnabled = false
                self.createAlert(title: "You're not yet in a house.", message: "Join or create one at 'Profile'", pop: false)
            
            // else update user interface with corresponding values
            } else {
                self.changeDrinksButton.isEnabled = true
                self.changeDrinksButton.backgroundColor = UIColor(red: 0.22, green: 0.57, blue: 0.47, alpha: 1.0)
                self.getOverviewButton.isEnabled = true
                
                // set UI
                self.updateValues()
                self.updateUI()
            }
        }
    }
    
    /// set variables in app
    func updateValues() {
        if let home = CurrentUser.houses[CurrentUser.user.house!] {
            self.totalDrinks = home.drinks
        }
        yourDrinks = CurrentUser.user.drinks
        drinksToBuy = CurrentUser.user.drinksToBuy
    }
    
    /// update total drinks
    func updateUI() {
        progressView.setProgress(Float(self.yourDrinks % 24) / 24.0, animated: true)
        totalDrinksLabel.text = String(self.totalDrinks)
        if totalDrinks == 0 {
            drinkOneButton.isEnabled = false
            drinkOneButton.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:0.5)
        } else {
            drinkOneButton.isEnabled = true
            drinkOneButton.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:1.0)
        }
    }
    
    /// get data and update values, room mates might have had a drink at the same time
    @IBAction func drinkOneButtonTapped(_ sender: UIButton) {
        getAllData {
            self.updateValues()
            self.totalDrinks -= 1
            self.yourDrinks += 1
            self.drinksToBuy += 1
            self.updateUI()
            
            // change drinks in database
            self.ref.child("houses/\(CurrentUser.user.house!)/drinks").setValue(self.totalDrinks)
            CurrentUser.ref.child("drinks").setValue(self.yourDrinks)
            CurrentUser.ref.child("drinksToBuy").setValue(self.drinksToBuy)
            
            // if user drank 24 beers, notify to buy crate
            if self.yourDrinks % 24 == 0 {
                self.createAlert(title: "Buy Crate!", message: "You drank 24 beers", pop: false)
            }
        }
    }
}
