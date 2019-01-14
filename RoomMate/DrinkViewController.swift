//
//  DrinkViewController.swift
//  RoomMate
//
//  Created by Fried on 07/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit

class DrinkViewController: UIViewController {
    var totalDrinks = 0
    var yourDrinks = 0
    

    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var totalDrinksLabel: UILabel!
    @IBOutlet weak var drinksInStoreLabel: UILabel!
    @IBOutlet weak var drinkOneButton: UIButton!
    @IBOutlet weak var minusOneButton: UIButton!
    @IBOutlet weak var plusOneButton: UIButton!
    @IBOutlet weak var plus24Button: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.setProgress(0, animated: true)
        drinkOneButton.applyDesign()
        minusOneButton.applyDesign()
        plusOneButton.applyDesign()
        plus24Button.applyDesign()
        // set your drinks
        
        updateUI()
    }
    
    /// update total drinks
    func updateUI() {
        progressView.setProgress(Float(yourDrinks)/24.0, animated: true)
        if yourDrinks == 24 {
            yourDrinks = 0
            createAlert(title: "Buy Crate!", message: "You drank 24 beers")
        }
        
        
        
        totalDrinksLabel.text = String(totalDrinks)
        if totalDrinks == 0 {
            drinkOneButton.isEnabled = false
            drinkOneButton.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:0.5)
            minusOneButton.isEnabled = false
            minusOneButton.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:0.5)
        } else {
            drinkOneButton.isEnabled = true
            drinkOneButton.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:1.0)
            minusOneButton.isEnabled = true
            minusOneButton.backgroundColor = UIColor(red:0.22, green:0.57, blue:0.47, alpha:1.0)
        }
        
    }
    
    ///
    @IBAction func drinkOneButtonTapped(_ sender: UIButton) {
        totalDrinks -= 1
        yourDrinks += 1
        
        // change drinks in house
        
        // change drinks for user
        
        updateUI()
    }
    
    ///
    @IBAction func minusOneButtonTapped(_ sender: UIButton) {
        totalDrinks -= 1
        updateUI()
    }
    
    ///
    @IBAction func plusOneButtonTapped(_ sender: UIButton) {
        totalDrinks += 1
        updateUI()
    }
    
    ///
    @IBAction func plus24ButtonTapped(_ sender: UIButton) {
        totalDrinks += 24
        updateUI()
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
}
