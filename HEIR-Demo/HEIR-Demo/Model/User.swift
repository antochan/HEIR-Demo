//
//  User.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/6/21.
//

import UIKit

public struct User: Codable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let accountType: AccountType
    let userImageURL: URL?
    let joinedAt: Double?
}

extension User {
    var fullName: String {
        return firstName + " " + lastName
    }
}
