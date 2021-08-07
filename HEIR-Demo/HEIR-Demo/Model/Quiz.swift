//
//  Quiz.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/6/21.
//

import UIKit

enum Reward: String, Codable, CaseIterable {
    case universityBlues
    case seafoam
    case travisScott
    case offwhite
    
    var title: String {
        switch self {
        case .universityBlues:
            return "AJ 1 University Blues"
        case .seafoam:
            return "AJ 1 Retro High 'Seafoam'"
        case .travisScott:
            return "AJ 1 Travis Scott"
        case .offwhite:
            return "AJ 1 Retro Off-White"
        }
    }
    
    var image: UIImage {
        switch self {
        case .universityBlues:
            return #imageLiteral(resourceName: "UniversityBlue")
        case .seafoam:
            return #imageLiteral(resourceName: "seafoam")
        case .travisScott:
            return #imageLiteral(resourceName: "travisScott")
        case .offwhite:
            return #imageLiteral(resourceName: "offwhite")
        }
    }
}

public struct Quiz: Codable {
    let id: String
    let quizName: String
    let reward: Reward
    let launchTime: Double
    let endTime: Double
}
