//
//  QuizSelection.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/8/21.
//

import UIKit

struct QuizSelection: Codable, Equatable {
    let id: String
    let selectedAnswer: String
    let timeTaken: Int
    let question: Question
}
