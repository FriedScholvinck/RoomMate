//
//  DrinkViewController.swift
//  RoomMate
//
//  Created by Fried on 07/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit
import Firebase

class DrinkViewController: UIViewController {
    let ref = Database.database().reference()
    var totalDrinks = 0
    var yourDrinks = 0
    var drinksBehind = 0
    
    @IBOutlet weak var getOverviewButton: UIBarButtonItem!
    @IBOutlet weak var changeDrinksButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var totalDrinksLabel: UILabel!
    @IBOutlet weak var drinksInStoreLabel: UILabel!
    @IBOutlet weak var drinkOneButton: UIButton!
    
    /// check if user is in house
    override func viewDidLoad() {
        super.viewDidLoad()
        changeDrinksButton.applyDesign()
        drinkOneButton.applyDesign()
        getData {
            if CurrentUser.user.house == nil {
                self.changeDrinksButton.isEnabled = false
                self.changeDrinksButton.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:0.5)
                self.getOverviewButton.isEnabled = false
                self.createAlert(title: "You're not yet in a house.", message: "Join or create one at 'Profile'")
            } else {
                self.changeDrinksButton.isEnabled = true
                self.changeDrinksButton.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:1.0)
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
        drinksBehind = CurrentUser.user.drinksBehind
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
        getData {
            self.updateValues()
            self.totalDrinks -= 1
            self.yourDrinks += 1
            self.drinksBehind += 1
            self.updateUI()
            
            // change drinks in database
            self.ref.child("houses/\(CurrentUser.user.house!)/drinks").setValue(self.totalDrinks)
            CurrentUser.ref.child("drinks").setValue(self.yourDrinks)
            CurrentUser.ref.child("drinksBehind").setValue(self.drinksBehind)
            
            if self.yourDrinks % 24 == 0 {
                self.createAlert(title: "Buy Crate!", message: "You drank 24 beers")
            }
        }
    }
}
