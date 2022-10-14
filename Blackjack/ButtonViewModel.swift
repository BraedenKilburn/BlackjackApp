//
//  ButtonViewModel.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 9/29/22.
//

import SwiftUI

class ButtonViewModel {
    public func deal(deck: [Card]?) -> (remainingDeck: [Card], toDealerHand: [Card], toPlayerHand: [Card]) {
        // Shuffle the deck... O(n)
        var shuffledDeck = deck!.shuffled()

        // Initialize empty card arrays ("hands")
        var dealerHand = [Card]()
        var playerHand = [Card]()

        // Deal two cards to the dealer and player one at a time
        // We use `removeLast()` because it's O(1),
        // we'll just call the top of the deck as the "last" item in the array
        for _ in 0 ..< 2 {
            playerHand.append(shuffledDeck.removeLast())
            dealerHand.append(shuffledDeck.removeLast())
        }

        SoundManager.instance.playSound(sound: .whoosh)
        // Return the triple containing the deck and player hands
        return (shuffledDeck, dealerHand, playerHand)
    }

    public func hit(deck: [Card]?, hand: [Card]?) -> (remainingDeck: [Card], newCard: Card) {
        // Retrieve a card from the deck
        var currentDeck = deck!
        
        let cardDrawn = currentDeck.removeLast()
        
        SoundManager.instance.playSound(sound: .whoosh)
        return (currentDeck, cardDrawn)
    }

    // This function is used to calculate the total score of a hand
    public func total(hand: [Card?]) -> Int {
        var aceCount = 0
        var handTotal = 0

        for card in hand {
            // If we have a Jack, Queen, or King, it's valued at 10
            if card!.value >= 11, card!.value <= 13 {
                handTotal += 10
            }

            // If we have an Ace, it's valued initially at 11
            else if card!.value == 14 {
                aceCount += 1
                handTotal += 11
            }

            // If the card is a number card, it's valued at its number
            else {
                handTotal += card!.value
            }

            // If we have an Ace and our hand total is over 21,
            // we need to change the Ace's value to 1
            while handTotal > 21, aceCount > 0 {
                handTotal -= 10
                aceCount -= 1
            }
        }

        return handTotal
    }

    // This function is used to determine the final result of the game
    public func result(playerScore: Int, dealerScore: Int) -> (result: Result, reasonForResult: String) {
        // If the player busted, they lose
        if playerScore > 21 {
            return (.lose, "You busted! You lose.")
        } else if playerScore == dealerScore {
            return (.push, "Push! It's a tie!")
        }

        // If the player has a blackjack, they win
        else if playerScore == 21 {
            return (.blackjack, "Blackjack! You win!")
        }

        // If the dealer busted, the player wins
        else if dealerScore > 21 {
            return (.win, "Dealer busted! You win!")
        }

        // If the dealer has a blackjack, they win
        else if dealerScore == 21 {
            return (.lose, "Dealer has blackjack. You lose.")
        }

        // If the player has a higher score than the dealer, they win
        else if playerScore > dealerScore {
            return (.win, "You win!")
        }

        // If the dealer has a higher score than the player, they win
        else if dealerScore > playerScore {
            return (.lose, "You lose.")
        }

        // If the player and dealer have the same score, it's a tie
        else {
            return (.push, "Push! It's a tie.")
        }
    }
}
