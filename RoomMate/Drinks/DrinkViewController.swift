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
    
    /// apply design
    override func viewDidLoad() {
        super.viewDidLoad()
        changeDrinksButton.applyDesign()
        drinkOneButton.applyDesign()
        getData {
            self.updateUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if CurrentUser.user.house == nil {
            changeDrinksButton.isEnabled = false
            changeDrinksButton.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:0.5)
            getOverviewButton.isEnabled = false
            createAlert(title: "You're not yet in a house.", message: "Join or create one at 'Profile'")
        } else {
            if let home = CurrentUser.houses[CurrentUser.user.house!] {
                totalDrinks = home.drinks
            }
            changeDrinksButton.isEnabled = true
            changeDrinksButton.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:1.0)
            getOverviewButton.isEnabled = true
        }
        yourDrinks = CurrentUser.user.drinks
        drinksBehind = CurrentUser.user.drinksBehind
        updateUI()
    }
    
    /// update total drinks
    func updateUI() {
        progressView.setProgress(Float(yourDrinks % 24) / 24.0, animated: true)        
        totalDrinksLabel.text = String(totalDrinks)
        if totalDrinks == 0 {
            drinkOneButton.isEnabled = false
            drinkOneButton.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:0.5)
        } else {
            drinkOneButton.isEnabled = true
            drinkOneButton.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:1.0)
        }
        
    }
    
    ///
    @IBAction func drinkOneButtonTapped(_ sender: UIButton) {
        totalDrinks -= 1
        yourDrinks += 1
        drinksBehind += 1
        if yourDrinks % 24 == 0 {
            createAlert(title: "Buy Crate!", message: "You drank 24 beers")
        }
        
        // change drinks in database
        ref.child("houses/\(CurrentUser.user.house!)/drinks").setValue(totalDrinks)
        CurrentUser.ref.child("drinks").setValue(yourDrinks)
        CurrentUser.ref.child("drinksBehind").setValue(drinksBehind)
        getData {
            self.updateUI()
        }
        
    }
    
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
}
