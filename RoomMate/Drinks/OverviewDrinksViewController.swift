//
//  OverviewDrinksViewController.swift
//  RoomMate
//
//  Created by Fried on 14/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit

class OverviewDrinksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var totalDrinksLabel: UILabel!
    @IBOutlet weak var drinksLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = CurrentUser.user.house

    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CurrentUser.houses[CurrentUser.user.house]!.residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    /// set cell text and image
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        cell.textLabel?.text = CurrentUser.houses[CurrentUser.user.house]!.residents[indexPath.row]
        cell.detailTextLabel?.text = "20"
    }

}
