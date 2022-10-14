//
//  Theme.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 10/12/22.
//

import SwiftUI

struct Theme: Codable, Identifiable {
    var id = UUID().uuidString
    
    var unlocked: [Color] = [.greenTableTop]
    var locked: [Color] = [.blueTableTop, .redTableTop, .yellowTableTop]
    var currentTheme: Color = .greenTableTop
    
    mutating func unlock(_ color: Color) {
        // Move color from locked to unlocked
        if let index = locked.firstIndex(of: color) {
            unlocked.append(locked.remove(at: index))
        }
    }

    mutating func setCurrentTheme(_ color: Color) {
        if isUnlocked(color) {
            currentTheme = color
        }
    }
    
    func isUnlocked(_ color: Color) -> Bool {
        return unlocked.contains(color)
    }

    func getAll() -> [Color] {
        return unlocked + locked
    }
}
