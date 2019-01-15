//
//  OverviewDrinksViewController.swift
//  RoomMate
//
//  Created by Fried on 14/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit

class OverviewDrinksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var residents = ["wim", "klaas", "piet", "kees"]
    
    @IBOutlet weak var drinkTableView: UITableView!
    @IBOutlet weak var totalDrinksLabel: UILabel!
    @IBOutlet weak var drinksLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drinkTableView.delegate = self
        drinkTableView.dataSource = self
        navigationItem.title = CurrentUser.user.house

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
        cell.detailTextLabel?.text = "20"
    }

}
