//
//  DrinkViewController.swift
//  RoomMate
//
//  Created by Fried on 07/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit

class DrinkViewController: UIViewController {

    @IBOutlet weak var beersInStoreLabel: UILabel!
    @IBOutlet weak var beersLabel: UILabel!
    @IBOutlet weak var drinkOneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drinkOneButton.applyDesign()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
