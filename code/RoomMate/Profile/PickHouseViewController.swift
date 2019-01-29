
//
//  PickHouseViewController.swift
//  RoomMate
//
//  Created by Fried on 10/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  This view controller lets the user pick a house and fill in its password to join.

import UIKit
import Firebase


class PickHouseViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    let ref = Database.database().reference()
    var pickerData: [String] = []
    var selectedRow = 0
    
    @IBOutlet weak var housePicker: UIPickerView!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        housePicker.dataSource = self
        housePicker.delegate = self
        passwordTextfield.delegate = self
        getAllData {
            self.setPickerData()
        }
    }
    
    /// load houses in picker view
    func setPickerData() {
        
        // don't show own house
        if let home = CurrentUser.user.house {
            pickerData = Array(CurrentUser.houses.keys).filter(){$0 != home}
        } else {
            pickerData = Array(CurrentUser.houses.keys)
            print(pickerData)
        }
        
        // if no other houses
        if pickerData == [] {
            pickerData = ["no houses available"]
            saveButton.isEnabled = false
        }
        
        // reload pickerview
        housePicker.reloadAllComponents()
    }
    
    /// save user in new house
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let house = pickerData[selectedRow]
        let password = CurrentUser.houses[house]?.password
        if passwordTextfield.text == password {
            
            // remove user from old house if any
            if let oldHome = CurrentUser.user.house {
                
                // check for residents left
                if (CurrentUser.houses[oldHome]?.residents.count)! > 1 {
                    
                    ref.child("houses/\(oldHome)/residents/\(CurrentUser.user.id)").removeValue()
                } else {
                    ref.child("houses/\(oldHome)").removeValue()
                }
            }
            
            CurrentUser.ref.child("house").setValue(house)
            ref.child("houses/\(house)/residents/\(CurrentUser.user.id)").setValue(true)
            
            // set user drinks to 0
            CurrentUser.ref.child("drinks").setValue(0)
            CurrentUser.ref.child("drinksToBuy").setValue(0)
            
            getAllData {
                self.createAlert(title: "Password Correct!", message: "You just joined \(house)", pop: true)
            }
            
        } else {
            createAlert(title: "Password Incorrect", message: "Try again!", pop: false)
        }
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
    
    /// hide keyboard with click on screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /// hide keyboard with return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextfield.resignFirstResponder()
        return true
    }
}
