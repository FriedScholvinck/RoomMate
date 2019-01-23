//
//  NewHouseViewController.swift
//  RoomMate
//
//  Created by Fried on 09/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  This

import UIKit
import Firebase

class NewHouseViewController: UIViewController, UITextFieldDelegate {
    let ref = Database.database().reference()
    
    @IBOutlet weak var createHouseLabel: UILabel!
    @IBOutlet weak var houseNameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var passwordAgainTextfield: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        houseNameTextfield.delegate = self
        passwordTextfield.delegate = self
        passwordAgainTextfield.delegate = self
    }
    
    /// save new house
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        var house = House()
        house.name = houseNameTextfield.text!
        if CurrentUser.houses.keys.contains(house.name) {
            createAlert(title: "\(house.name) Already Exists", message: "Please Try Again", pop: false)
            return
        }
        house.password = passwordTextfield.text!
        house.residents = [CurrentUser.user.id]
        
        // remove user from old house if any
        if let oldHome = CurrentUser.user.house {
            
            // check for residents left
            if (CurrentUser.houses[oldHome]?.residents.count)! > 1 {
                
                ref.child("houses/\(oldHome)/residents/\(CurrentUser.user.id)").removeValue()
            } else {
                ref.child("houses/\(oldHome)").removeValue()
            }
        }
        
        // create new house
        ref.child("houses/\(house.name)").setValue(["password":house.password, "drinks": 0, "residents": [CurrentUser.user.id: true], "tasks": ["default": true], "firstWeek": 0])
        
        // set user in new house
        CurrentUser.ref.child("house").setValue(house.name)
        CurrentUser.ref.child("drinks").setValue(0)
        CurrentUser.ref.child("drinksToBuy").setValue(0)

        getAllData {
            
            // alert user in application
            self.createAlert(title: "Succesfully Created '\(house.name)'", message: "Password: \(house.password)", pop: true)
        }
    }
    
    ///
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveButton.isEnabled = filledIn()
    }
    
    ///
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func filledIn() -> Bool {
        return houseNameTextfield.hasText && passwordTextfield.hasText && passwordAgainTextfield.hasText && passwordTextfield.text == passwordAgainTextfield.text
    }

    /// hide keyboard with click on screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
