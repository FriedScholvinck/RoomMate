
//
//  AddDrinksViewController.swift
//  RoomMate
//
//  Created by Fried on 15/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  This view controller holds the ability to update the total drinks in the house by adding or extracting drinks. They can either be bought by the user or just changed when bought from a joint account. The view has many buttons and labels with calculations in place. Only when the 'Save' button is tapped, the changes will be saved online and locally.

import UIKit
import Firebase


class AddDrinksViewController: UIViewController {
    let ref = Database.database().reference()
    var totalDrinks = 0
    var newTotalDrinks = 0
    var boughtTotal = 0
    var changeTotal = 0
    var drinksToBuy = 0
    
    // when bought, change total drinks outlets
    @IBOutlet weak var boughtLabel: UILabel!
    @IBOutlet weak var totalBoughtLabel: UILabel!
    @IBOutlet weak var plusOneBoughtButton: UIButton!
    @IBOutlet weak var plus24BoughtButton: UIButton!
    
    // change total drinks outlets
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var minusOneButton: UIButton!
    @IBOutlet weak var plusOneButton: UIButton!
    @IBOutlet weak var plus24Button: UIButton!
    @IBOutlet weak var totalChangeLabel: UILabel!
    
    @IBOutlet weak var totalDrinksLabel: UILabel!
    @IBOutlet weak var drinksToBuyLabel: UILabel!
    
    /// apply design, get data from database and update interface
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
    
    /// update local variables from global current user struct
    func updateValues() {
        totalDrinks = CurrentUser.houses[CurrentUser.user.house!]!.drinks
        drinksToBuy = CurrentUser.user.drinksToBuy
    }
    
    /// update interface
    func updateUI() {
        newTotalDrinks = totalDrinks + boughtTotal + changeTotal
        totalBoughtLabel.text = String(boughtTotal)
        totalChangeLabel.text = String(changeTotal)
        totalDrinksLabel.text = String(newTotalDrinks)
        
        // don't show minus if drinksToBuy is below 0 -> the user won't have to buy drinks yet
        if drinksToBuy < 0 {
            drinksToBuyLabel.text = "0"
        } else {
            drinksToBuyLabel.text = String(drinksToBuy)
        }
        
        // if there are no drinks in the house, they can't be removed
        if totalDrinks == 0 {
            minusOneButton.isEnabled = false
            minusOneButton.backgroundColor = UIColor(red: 0.22, green: 0.57, blue: 0.47, alpha: 0.5)
        } else {
            minusOneButton.isEnabled = true
            minusOneButton.backgroundColor = UIColor(red: 0.22, green: 0.57, blue: 0.47, alpha: 1.0)
        }
    }
    
    /// save local changes in total drinks to online database and notify user once succeeded
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        CurrentUser.houses[CurrentUser.user.house!]!.drinks = newTotalDrinks
        ref.child("houses/\(CurrentUser.user.house!)/drinks").setValue(newTotalDrinks)
        CurrentUser.ref.child("drinksToBuy").setValue(drinksToBuy)
        getAllData() {
            self.createAlert(title: "Succesfully Added", message: "Enjoy Your Drinks!", pop: true)
        }
    }
    
    /// change local variables, update interface
    @IBAction func plusOneBoughtButtonTapped(_ sender: UIButton) {
        boughtTotal += 1
        drinksToBuy -= 1
        updateUI()
    }
    
    /// change local variables, update interface
    @IBAction func plus24BoughtButtonTapped(_ sender: UIButton) {
        boughtTotal += 24
        drinksToBuy -= 24
        updateUI()
    }
    
    /// change local variables, update interface
    @IBAction func minusOneButtonTapped(_ sender: UIButton) {
        changeTotal -= 1
        updateUI()
    }
    
    /// change local variables, update interface
    @IBAction func plusOneButtonTapped(_ sender: UIButton) {
        changeTotal += 1
        updateUI()
    }
    
    /// change local variables, update interface
    @IBAction func plus24ButtonTapped(_ sender: UIButton) {
        changeTotal += 24
        updateUI()
    }
}
