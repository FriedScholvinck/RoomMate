
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
    var boughtTotal = 0
    var changeTotal = 0
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        plusOneBoughtButton.applyDesign()
        plus24BoughtButton.applyDesign()
        minusOneButton.applyDesign()
        plusOneButton.applyDesign()
        plus24Button.applyDesign()
        totalDrinks = CurrentUser.houses[CurrentUser.user.house!]!.drinks
        updateUI()
    }
    
    func updateUI() {
        totalDrinks = totalDrinks + boughtTotal + changeTotal
        totalBoughtLabel.text = String(boughtTotal)
        totalChangeLabel.text = String(changeTotal)
        totalDrinksLabel.text = String(totalDrinks)
        if totalDrinks == 0 {
            minusOneButton.isEnabled = false
            minusOneButton.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:0.5)
        } else {
            minusOneButton.isEnabled = true
            minusOneButton.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:1.0)
        }
    }
    
    ///
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        
        CurrentUser.houses[CurrentUser.user.house!]!.drinks = totalDrinks
        ref.child("houses/\(CurrentUser.user.house!)/drinks").setValue(totalDrinks)
        
        
        createAlert(title: "Succesfully Added", message: "Enjoy Your Drinks!")
    }
    
    /// creates alert to notify user
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func plusOneBoughtButtonTapped(_ sender: UIButton) {
        boughtTotal += 1
        updateUI()
    }
    
    @IBAction func plus24BoughtButtonTapped(_ sender: UIButton) {
        boughtTotal += 24
        updateUI()
    }
    
    ///
    @IBAction func minusOneButtonTapped(_ sender: UIButton) {
        changeTotal -= 1
        updateUI()
    }
    
    ///
    @IBAction func plusOneButtonTapped(_ sender: UIButton) {
        changeTotal += 1
        updateUI()
    }
    
    ///
    @IBAction func plus24ButtonTapped(_ sender: UIButton) {
        changeTotal += 24
        updateUI()
    }
}
