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
    
    @IBOutlet weak var drinkTableView: UITableView!
    @IBOutlet weak var totalDrinksLabel: UILabel!
    @IBOutlet weak var drinksLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drinkTableView.delegate = self
        drinkTableView.dataSource = self
        navigationItem.title = CurrentUser.user.house
        getResidents()
        drinksLabel.text = String(drinks.reduce(0, +))
    }
    
    func getResidents() {
        for memberID in (CurrentUser.houses[CurrentUser.user.house!]?.residents)! {
            residents.append((CurrentUser.users[memberID]?.name)!)
            drinks.append((CurrentUser.users[memberID]?.drinks)!)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        residents = (CurrentUser.houses[CurrentUser.user.house]?.residents)!
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    /// set cell text and image
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        cell.textLabel?.text = residents[indexPath.row]
        cell.detailTextLabel?.text = String(drinks[indexPath.row])
    }

}
