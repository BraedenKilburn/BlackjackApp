//
//  Status.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 9/27/22.
//

import Foundation

struct Player: Codable, Identifiable {
    var id = UUID().uuidString

    var totalWins: Int = 0
    var totalLosses: Int = 0
    var totalPushes: Int = 0
    var totalCreditsLost: Float = 0
    var totalCreditsWon: Float = 0

    var hand: [Card]? = []
    var totalCardScore: Int = 0
    var bet: Int = 0
    var credits: Float = 500

    // Initialize and make it as optional
    init(totalWins: Int = 0,
         totalLosses: Int = 0,
         totalPushes: Int = 0,
         totalCreditsLost: Float = 0,
         totalCreditsWon: Float = 0,
         hand: [Card]? = [],
         totalCardScore: Int = 0,
         bet: Int = 0,
         credits: Float = 500)
    {
        self.totalWins = totalWins
        self.totalLosses = totalLosses
        self.totalPushes = totalPushes
        self.totalCreditsLost = totalCreditsLost
        self.totalCreditsWon = totalCreditsWon
        self.hand = hand
        self.totalCardScore = totalCardScore
        self.bet = bet
        self.credits = credits
    }
}

extension Player {
    var totalGames: Int {
        return totalWins + totalLosses + totalPushes
    }
    
    mutating func reset() {
        self.hand = []
        self.totalCardScore = 0
        self.bet = 0
    }
}
