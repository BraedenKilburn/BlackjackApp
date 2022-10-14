//
//  DealerHandView.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 9/27/22.
//

import SwiftUI

struct DealerHandView: View {
    @State var isAnimating: Bool = false

    @Binding var dealer: Player
    @Binding var gameState: GameState

    private let vm = HandDisplayViewModel()

    var body: some View {
        let arrayOfCards = vm.getImageLocations(hand: dealer.hand!)

        ZStack {
            ForEach(0 ..< arrayOfCards.count, id: \.self) { index in
                // If it's the first card and the dealer's hand hasn't been revealed (show card back)
                if index == 0 && gameState == GameState.start {
                    CardView(location: "0_back_of_card")
                        .cornerRadius(5)
                        .offset(x: isAnimating ? vm.cardAlignment(numOfCards: arrayOfCards.count, index: index) : 500)
                }
                // If it's the last card and the game is over (show dealer's hand value)
                else if index == arrayOfCards.count - 1 && gameState == GameState.finished {
                    CardView(location: arrayOfCards[index])
                        .offset(x: isAnimating ? vm.cardAlignment(numOfCards: arrayOfCards.count, index: index) : 500)
                        .overlay(dealer.totalCardScore != 0
                            ? HandValueBadge(value: $dealer.totalCardScore)
                            .offset(x: isAnimating ? vm.cardAlignment(numOfCards: arrayOfCards.count, index: index) : 500)
                            : nil)
                }
                // If it's anything else, just print the card only
                else {
                    // Card that flies in from the right
                    CardView(location: arrayOfCards[index])
                        .offset(x: isAnimating ? vm.cardAlignment(numOfCards: arrayOfCards.count, index: index) : 500)
                }
            }
            .animation(.easeOut(duration: 1), value: isAnimating)
            .onAppear {
                isAnimating = true
            }
            .onDisappear {
                isAnimating = false
            }
        }
    }
}

struct DealerHandView_Previews: PreviewProvider {
    static var previews: some View {
        DealerHandView(dealer: .constant(Player(
            hand: [Card(suit: "spades", value: 3, location: "3_of_spades"),
                   Card(suit: "hearts", value: 1, location: "ace_of_hearts")]
        )), gameState: .constant(GameState.finished))
    }
}
