//
//  OpenAppViewController.swift
//  RoomMate
//
//  Created by Fried on 10/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  This (initial) view controller is only to check if the user has logged in already via AppManager.swift

import UIKit

class AppContainerViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppManager.shared.appContainer = self
        AppManager.shared.showApp()
    }
}
