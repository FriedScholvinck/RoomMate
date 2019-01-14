//
//  NewHouseViewController.swift
//  RoomMate
//
//  Created by Fried on 09/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit
import Firebase


class NewHouseViewController: UIViewController, UITextFieldDelegate {
    
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
        print(CurrentUser.houses.keys)
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
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// save new house
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        var house = House()
        house.name = houseNameTextfield.text!
        print(CurrentUser.houses.keys)
        if CurrentUser.houses.keys.contains(house.name) {
            createAlert(title: "\(house.name) Already Exists", message: "Please Try Again")
        }
        house.password = passwordTextfield.text!
        house.residents = [CurrentUser.user.id]
        CurrentUser.houses[house.name] = house
        CurrentUser.houses[house.name] = house
        DataController.shared.createNewHouse(name: house.name, password: house.password, residents: house.residents)
        createAlert(title: "Succesfully Created \(house.name)", message: "Password: \(house.password)")
    }

    
}
