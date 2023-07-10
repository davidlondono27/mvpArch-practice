//
//  Task.swift
//  To-Do MVP Practice
//
//  Created by David Santiago Londono Giraldo on 9/07/23.
//

import Foundation

struct Task {
    let id: UUID = UUID()
    let text: String
    var isFavorite: Bool
}
