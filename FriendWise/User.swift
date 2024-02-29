//
//  User.swift
//  FriendWise
//
//  Created by ramsayleung on 2024-02-28.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: Array<String>
    var friends: Array<Friend>
}
