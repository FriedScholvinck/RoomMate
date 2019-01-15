//
//  CleanViewController.swift
//  RoomMate
//
//  Created by Fried on 07/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit
import Firebase

class CleanViewController: UIViewController {
    let ref = Database.database().reference()

    @IBOutlet weak var yourScheduleButton: UIButton!
    @IBOutlet weak var createScheduleButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yourScheduleButton.applyDesign()
        createScheduleButton.applyDesign()
        
        
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
