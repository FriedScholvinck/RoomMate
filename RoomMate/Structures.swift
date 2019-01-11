//
//  RoomMates.swift
//  RoomMate
//
//  Created by Fried on 09/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import Foundation

struct User: Decodable {
    var id: Int
    var name: String
//    var email: String
    var house: String
}

struct House: Decodable {
    var id: Int
    var name: String
    var password: String
    var residents: [Int]
//    var cleaningSchedule: CleaningSchedule
    var drinks: Int
}

struct CleaningSchedule: Decodable {
    
}

struct Drinks: Decodable {
    
}
