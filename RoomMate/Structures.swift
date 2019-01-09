//
//  RoomMates.swift
//  RoomMate
//
//  Created by Fried on 09/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import Foundation

struct User: Decodable {
    var id: String
    var name: String
    var email: String
    var house: House
}

struct House: Decodable {
    var id: Int
    var name: String
    var residents: [User]
    var cleaningSchedule: CleaningSchedule
    var drinks: Drinks
}

struct CleaningSchedule: Decodable {
    
}

struct Drinks: Decodable {
    
}
