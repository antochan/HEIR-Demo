//
//  Question.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/7/21.
//

import UIKit

public struct Question: Codable {
    let id: String
    let question: String
    let answer: String
    let options: [String]
}

extension Question: Equatable {
    public static func ==(lhs: Question, rhs: Question) -> Bool {
        return lhs.id == rhs.id
    }
}
