//
//  NewHouseViewController.swift
//  RoomMate
//
//  Created by Fried on 09/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  This view controller holds the functionality to create a new house with a name and password. The user will automatically move to this new house.

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
    
    /// save new house and move user in it
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        var house = House()
        house.name = houseNameTextfield.text!
        
        // return if house name already exists
        if CurrentUser.houses.keys.contains(house.name) {
            createAlert(title: "\(house.name) Already Exists", message: "Please Try Again", pop: false)
            return
        }
        
        house.password = passwordTextfield.text!
        house.residents = [CurrentUser.user.id]
        
        // remove user from old house if any
        if let oldHome = CurrentUser.user.house {
            
            // check for residents left, if none -> remove house
            if (CurrentUser.houses[oldHome]?.residents.count)! > 1 {
                
                ref.child("houses/\(oldHome)/residents/\(CurrentUser.user.id)").removeValue()
            } else {
                ref.child("houses/\(oldHome)").removeValue()
            }
        }
        
        // create new house
        ref.child("houses/\(house.name)").setValue(["password":house.password, "drinks": 0, "residents": [CurrentUser.user.id: true], "tasks": ["default": true], "firstWeek": 0])
        
        // set user in new house with empty drinking data
        CurrentUser.ref.child("house").setValue(house.name)
        CurrentUser.ref.child("drinks").setValue(0)
        CurrentUser.ref.child("drinksToBuy").setValue(0)
        
        // alert user if succeded the new data has been set locally
        getAllData {
            self.createAlert(title: "Succesfully Created '\(house.name)'", message: "Password: \(house.password)", pop: true)
        }
    }
    
    /// enable or disable save button if user has filled in all required textfields
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveButton.isEnabled = filledIn()
    }
    
    /// helper function to enable/disable save button
    func filledIn() -> Bool {
        return houseNameTextfield.hasText && passwordTextfield.hasText && passwordAgainTextfield.hasText && passwordTextfield.text == passwordAgainTextfield.text
    }
    
    /// hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /// hide keyboard with click on screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
