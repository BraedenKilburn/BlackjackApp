//
//  PlayerHandView.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 9/27/22.
//

import SwiftUI

struct PlayerHandView: View {
    @State var isAnimatingBeginning: Bool = false
    @State var isAnimatingHit: Bool = false

    @Binding var player: Player

    private let vm = HandDisplayViewModel()

    var body: some View {
        let arrayOfCards = vm.getImageLocations(hand: player.hand!)

        ZStack {
            ForEach(0 ..< arrayOfCards.count, id: \.self) { index in
                // If we're displaying the last card, show the hand value badge
                if index == arrayOfCards.count - 1 {
                    CardView(location: arrayOfCards[index])
                        .offset(x: isAnimatingHit ? vm.cardAlignment(numOfCards: arrayOfCards.count, index: index) :
                            (isAnimatingBeginning ? vm.cardAlignment(numOfCards: arrayOfCards.count, index: index) : 500))
                        .overlay(player.totalCardScore != 0
                            ? HandValueBadge(value: $player.totalCardScore)
                            .offset(x: isAnimatingHit ? vm.cardAlignment(numOfCards: arrayOfCards.count, index: index) :
                                (isAnimatingBeginning ? vm.cardAlignment(numOfCards: arrayOfCards.count, index: index) : 500))
                            : nil)
                } else { // Just show the normal card
                    CardView(location: arrayOfCards[index])
                        .offset(x: isAnimatingHit ? vm.cardAlignment(numOfCards: arrayOfCards.count, index: index) :
                            (isAnimatingBeginning ? vm.cardAlignment(numOfCards: arrayOfCards.count, index: index) : 500))
                }
            }
            .animation(.easeOut(duration: 1), value: isAnimatingHit || isAnimatingBeginning)
            .onAppear {
                isAnimatingBeginning = player.hand!.count == 2
                isAnimatingHit = player.hand!.count > 2
            }
        }
    }
}

struct PlayerHandView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerHandView(player: .constant(Player(
            hand: [Card(suit: "spades", value: 3, location: "3_of_spades"),
                  Card(suit: "hearts", value: 1, location: "ace_of_hearts")]
        )))
    }
}
