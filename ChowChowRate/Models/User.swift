//
//  User.swift
//  GrubRate
//
//  Created by Andres Made on 4/14/24.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
    var username: String
    var email: String
}

extension User {
    static var exampleUser = User(id: UUID().uuidString, username: "djTwist", email: "djtwist23@gmail.com")
}
