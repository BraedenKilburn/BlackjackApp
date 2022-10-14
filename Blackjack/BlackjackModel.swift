//
//  BlackjackModel.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 9/21/22.
//

import Foundation

struct BlackjackModel {
    var cards: [Card]
    var player = Player()
    var dealer = Dealer()
}

struct Player {
    var hand = [Card]()

    var value: Int {
        return getHandValue(hand: hand)
    }
}

struct Dealer {
    var hand = [Card]()

    var value: Int {
        return getHandValue(hand: hand)
    }
}

func getHandValue(hand: [Card]) -> Int {
    return hand.reduce(0) { result, card in
        result + card.rank.value
    }
}
