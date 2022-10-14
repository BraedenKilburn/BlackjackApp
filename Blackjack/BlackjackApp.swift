//
//  BlackjackApp.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 9/20/22.
//

import SwiftUI

@main
struct BlackjackApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isSoundOn") private var isSoundOn = true
    
    var body: some Scene {
        WindowGroup {
            HomePage()
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
