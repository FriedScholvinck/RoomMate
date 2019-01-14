//
//  RoomMates.swift
//  RoomMate
//
//  Created by Fried on 09/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import Foundation
import Firebase

struct CurrentUser {
    static var user = User(id: "", name: "", email: "", house: "")
    static var users: [String: User] = [:]
    static var houses: [String: House] = [:]
}

struct User: Decodable {
    var id: String
    var name: String
    var email: String
    var house: String
}

//class FIRUser: NSObject {
//    var id: String?
//    var name: String?
//    var email: String?
//    var house: String?
//}

//class FIRHouse: NSObject {
//    var name: String?
//    var password: String?
//    var residents: [String: Bool] = [:]
//}

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
