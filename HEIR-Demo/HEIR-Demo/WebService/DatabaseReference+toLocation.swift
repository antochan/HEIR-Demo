//
//  DatabaseReference+toLocation.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/6/21.
//

import Foundation
import Firebase

extension CollectionReference {
    enum Location: String {
        case users
        case quiz
        
        func asDatabaseReference() -> CollectionReference {
            switch self {
            case .users:
                return Firestore.firestore().collection("users")
            case .quiz:
                return Firestore.firestore().collection("quiz")
            }
        }
    }
    
    static func toLocation(_ location: Location) -> CollectionReference {
        return location.asDatabaseReference()
    }
}
