
//
//  PickHouseViewController.swift
//  RoomMate
//
//  Created by Fried on 10/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  COMMENTS

import UIKit

class PickHouseViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    var pickerData = [String]()
    var selectedRow = 0
    
    @IBOutlet weak var housePicker: UIPickerView!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        housePicker.dataSource = self
        housePicker.delegate = self
        passwordTextfield.delegate = self
        
//        pickerData = CurrentUser.houses.keys
        
        pickerData = ["huis 1", "huis 2", "huis 3", "huis 4", "huis 5", "huis 6"]
    }
    
    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let house = pickerData[selectedRow]
        let password = CurrentUser.houses[house]?.password
        if passwordTextfield.text == password {
            // set user in house
            CurrentUser.user.house = house
            createAlert(title: "Password Correct!", message: "You just joined \(pickerData[selectedRow])")
        }
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
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
