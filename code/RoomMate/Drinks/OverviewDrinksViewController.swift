//
//  OverviewDrinksViewController.swift
//  RoomMate
//
//  Created by Fried on 14/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit
import Firebase

class OverviewDrinksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let ref = Database.database().reference()
    var residents: [String] = []
    var drinks: [Int] = []
    var drinksToBuy: [Int] = []
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var drinkTableView: UITableView!
    @IBOutlet weak var totalDrinksLabel: UILabel!
    @IBOutlet weak var drinksLabel: UILabel!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drinkTableView.delegate = self
        drinkTableView.dataSource = self
        getAllData {
            self.getResidentNames()
            self.drinkTableView.reloadData()
        }
    }
    
    /// get table view date (names and drinks)
    func getResidentNames() {
        for memberID in CurrentUser.residents {
            residents.append((CurrentUser.users[memberID]?.name)!)
            drinks.append((CurrentUser.users[memberID]?.drinks)!)
            drinksToBuy.append((CurrentUser.users[memberID]?.drinksToBuy)!)
            
            // sum up all drink for total
            drinksLabel.text = String(drinks.reduce(0, +))
        }
    }
    
    /// data reload in other segment
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        drinkTableView.reloadData()
    }
    
    /// set all drinking data to zero (first check if user is sure)
    @IBAction func trashButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Are You Sure?", message: "All drinking data will be deleted", preferredStyle: .alert)
        
        // delete all drinking data
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            for user in CurrentUser.residents {
                self.ref.child("users/\(user)/drinks").setValue(0)
                self.ref.child("users/\(user)/drinksToBuy").setValue(0)
            }
            self.ref.child("houses/\(CurrentUser.user.house!)/drinks").setValue(0)
            
            // go back to DrinkViewController
            self.getAllData {
                _ = self.navigationController?.popViewController(animated: true)
            }
            
        }))
        
        // cancel removal
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    /// helper function for setting table view
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        cell.textLabel?.text = residents[indexPath.row]
        if segmentControl.selectedSegmentIndex == 1 {
            cell.detailTextLabel?.text = String(drinks[indexPath.row])
        } else {
            cell.detailTextLabel?.text = String(drinksToBuy[indexPath.row])
        }
    }
}
