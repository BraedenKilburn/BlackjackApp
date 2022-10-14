//
//  OptionButton.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 9/29/22.
//

import SwiftUI

extension OptionButtons {
    private func OptionButton(action: @escaping () -> Void, imageName: String, label: String) -> some View {
        GeometryReader { geometry in
            VStack {
                Button {
                    action()
                } label: {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
                Text(label)
                    .font(.system(size: 25))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 100, height: 150)
    }
}

struct OptionButtons: View {
    private let vm = ButtonViewModel()
    var mode: Binding<PresentationMode>
    @Binding var gameState: GameState
    @Binding var message: String
    @Binding var deck: [Card]?
    @Binding var player: Player
    @Binding var dealer: Player
    @State var originalBet: Int = 0

    var body: some View {
        HStack {
            switch gameState {
            case .reset:
                OptionButton(action: leave, imageName: "Quit", label: "Quit").padding()

                if player.bet != 0 {
                    OptionButton(action: dealCards, imageName: "Deal", label: "Deal").padding()
                }
            case .start:
                player.hand?.count == 2 ? OptionButton(action: doubleDown, imageName: "DoubleDown", label: "Double") : nil
                OptionButton(action: stand, imageName: "Stand", label: "Stand")
                OptionButton(action: hit, imageName: "Hit", label: "Hit")
            case .finished:
                OptionButton(action: leave, imageName: "Quit", label: "Quit").padding()
                OptionButton(action: reset, imageName: "PlayAgain", label: "Replay").padding()
            }
        }
    }

    func leave() {
        reset()
        player.bet = 0
        FileSystemService().setPlayer(player: player)
        mode.wrappedValue.dismiss()
    }

    func dealCards() {
        // Variables updated for deal action
        let dealt = vm.deal(deck: deck)

        deck = dealt.remainingDeck
        dealer.hand = dealt.toDealerHand
        player.hand = dealt.toPlayerHand

        player.credits -= Float(player.bet)
        updatePlayerScore()
        updateDealerScore()

        // Update UI
        gameState = GameState.start

        // Check for blackjack
        if player.totalCardScore == 21 {
            dealerHits()
            calculateFinalScores()
        } else {
            message = "Hit or Stand?"
        }
    }

    func hit() {
        let hitPlayer = vm.hit(deck: deck, hand: player.hand)

        player.hand?.append(hitPlayer.newCard)

        deck = hitPlayer.remainingDeck

        updatePlayerScore()

        // Check if player busted or has a blackjack
        if player.totalCardScore > 21 {
            calculateFinalScores()
        } else if player.totalCardScore == 21 {
            dealerHits()
            calculateFinalScores()
        }
    }

    func stand() {
        dealerHits()
        calculateFinalScores()
    }

    func doubleDown() {
        // Double player bet
        originalBet = player.bet
        player.credits -= Float(player.bet)
        player.bet *= 2

        // Hit player
        let hitPlayer = vm.hit(deck: deck, hand: player.hand)

        player.hand?.append(hitPlayer.newCard)
        deck = hitPlayer.remainingDeck

        updatePlayerScore()

        // Check if player busted or is otherwise still in the game
        if player.totalCardScore > 21 {
            calculateFinalScores()
        } else {
            dealerHits()
            calculateFinalScores()
        }
    }

    func reset() {
        message = "Place your bet and press deal to start."

        deck = loadJson(withFilename: "deck_of_cards")

        player.hand = []
        player.totalCardScore = 0

        if player.bet > Int(player.credits) { player.bet = 0 }
        else if player.bet >= originalBet, originalBet != 0 { player.bet = originalBet }

        dealer.hand = []
        dealer.totalCardScore = 0

        gameState = GameState.reset
    }

    func dealerHits() {
        // The dealer hits until their score becomes 17 or higher
        while dealer.totalCardScore < 17 {
            let hitDealer = vm.hit(deck: deck, hand: dealer.hand)
            dealer.hand?.append(hitDealer.newCard)
            deck = hitDealer.remainingDeck
            updateDealerScore()
        }
    }

    func calculateFinalScores() {
        // Assigns a score to the winner
        let results = vm.result(playerScore: player.totalCardScore, dealerScore: dealer.totalCardScore)

        switch results.result {
        case .blackjack:
            SoundManager.instance.playSound(sound: .win)
            player.totalCreditsWon += Float(player.bet) * 2.5
            player.credits += Float(player.bet) * 2.5
            player.totalWins += 1
        case .win:
            SoundManager.instance.playSound(sound: .win)
            player.credits += Float(player.bet * 2)
            player.totalCreditsWon += Float(player.bet * 2)
            player.totalWins += 1
        case .push:
            SoundManager.instance.playSound(sound: .push)
            player.credits += Float(player.bet)
            player.totalPushes += 1
        default:
            SoundManager.instance.playSound(sound: .lose)
            player.totalCreditsLost += Float(player.bet)
            player.totalLosses += 1
        }

        FileSystemService().setPlayer(player: player)

        // Updates UI
        message = results.reasonForResult
        gameState = GameState.finished
    }

    func updatePlayerScore() {
        let playerTotal = vm.total(hand: player.hand!)

        player.totalCardScore = playerTotal

        // If the player busts, end the game
        if player.totalCardScore > 21 {
            calculateFinalScores()
        }
    }

    func updateDealerScore() {
        let dealerTotal = vm.total(hand: dealer.hand!)
        dealer.totalCardScore = dealerTotal
    }
}
