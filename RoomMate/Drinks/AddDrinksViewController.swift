
//
//  AddDrinksViewController.swift
//  RoomMate
//
//  Created by Fried on 15/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit
import Firebase

class AddDrinksViewController: UIViewController {
    let ref = Database.database().reference()
    var totalDrinks = 0
    var newTotalDrinks = 0
    var boughtTotal = 0
    var changeTotal = 0
    var drinksToBuy = 0
    
    // when bought, change total drinks
    @IBOutlet weak var boughtLabel: UILabel!
    @IBOutlet weak var totalBoughtLabel: UILabel!
    @IBOutlet weak var plusOneBoughtButton: UIButton!
    @IBOutlet weak var plus24BoughtButton: UIButton!
    
    // change total drinks
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var minusOneButton: UIButton!
    @IBOutlet weak var plusOneButton: UIButton!
    @IBOutlet weak var plus24Button: UIButton!
    @IBOutlet weak var totalChangeLabel: UILabel!
    
    
    @IBOutlet weak var totalDrinksLabel: UILabel!
    @IBOutlet weak var drinksToBuyLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        plusOneBoughtButton.applyDesign()
        plus24BoughtButton.applyDesign()
        minusOneButton.applyDesign()
        plusOneButton.applyDesign()
        plus24Button.applyDesign()
        getAllData {
            self.updateValues()
            self.updateUI()
        }
    }
    
    func updateValues() {
        totalDrinks = CurrentUser.houses[CurrentUser.user.house!]!.drinks
        drinksToBuy = CurrentUser.user.drinksToBuy
    }
    
    func updateUI() {
        newTotalDrinks = totalDrinks + boughtTotal + changeTotal
        totalBoughtLabel.text = String(boughtTotal)
        totalChangeLabel.text = String(changeTotal)
        totalDrinksLabel.text = String(newTotalDrinks)
        if drinksToBuy < 0 {
            drinksToBuyLabel.text = "0"
        } else {
            drinksToBuyLabel.text = String(drinksToBuy)
        }
        
        if totalDrinks == 0 {
            minusOneButton.isEnabled = false
            minusOneButton.backgroundColor = UIColor(red: 0.22, green: 0.57, blue: 0.47, alpha: 0.5)
        } else {
            minusOneButton.isEnabled = true
            minusOneButton.backgroundColor = UIColor(red: 0.22, green: 0.57, blue: 0.47, alpha: 1.0)
        }
    }
    
    ///
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        CurrentUser.houses[CurrentUser.user.house!]!.drinks = newTotalDrinks
        ref.child("houses/\(CurrentUser.user.house!)/drinks").setValue(newTotalDrinks)
        CurrentUser.ref.child("drinksToBuy").setValue(drinksToBuy)
        getAllData() {
            self.createAlert(title: "Succesfully Added", message: "Enjoy Your Drinks!", pop: true)
        }
    }

    
    @IBAction func plusOneBoughtButtonTapped(_ sender: UIButton) {
        boughtTotal += 1
        drinksToBuy -= 1
        updateUI()
    }
    
    @IBAction func plus24BoughtButtonTapped(_ sender: UIButton) {
        boughtTotal += 24
        drinksToBuy -= 24
        updateUI()
    }
    
    @IBAction func minusOneButtonTapped(_ sender: UIButton) {
        changeTotal -= 1
        updateUI()
    }
    
    @IBAction func plusOneButtonTapped(_ sender: UIButton) {
        changeTotal += 1
        updateUI()
    }
    
    @IBAction func plus24ButtonTapped(_ sender: UIButton) {
        changeTotal += 24
        updateUI()
    }
}
