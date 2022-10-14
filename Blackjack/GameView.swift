//
//  ContentView.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 9/20/22.
//

import SwiftUI

struct GameView: View {
    // MARK: - PROPERTY

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var message: String = "Place your bet and press deal to start."
    @State var deck: [Card]? = loadJson(withFilename: "deck_of_cards")
    @State var dealer = Player()
    @State var gameState = GameState.reset
    @State private var isAlerting = false
    @Binding var themes: Theme
    @Binding var player: Player

    // MARK: - BODY

    var body: some View {
        ZStack {
            cardTable

            VStack {
                DealerHandView(dealer: $dealer, gameState: $gameState)

                Spacer()

                MessageView(message: $message)

                Spacer()

                if player.hand?.count == 0 {
                    PlaceBetView(bet: $player.bet, playersCredits: $player.credits).padding(.top)
                } else {
                    PlayerHandView(player: $player)
                }

                Spacer()

                OptionButtons(mode: mode, gameState: $gameState, message: $message, deck: $deck, player: $player, dealer: $dealer)
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(
            leading:
            Button(action: {
                if gameState == .start {
                    isAlerting = true
                } else {
                    player.reset()
                    self.mode.wrappedValue.dismiss()
                }
            }) {
                NavbarBackButton(message: "Leave Table")
            }
                .alert(isPresented: $isAlerting) {
                    // Alert the user that they cannot leave the table if they have not finished their hand
                    Alert(
                        title: Text("Unable to leave"),
                        message: Text("You must finish your hand before leaving the table."),
                        dismissButton: .default(Text("Ok"))
                    )
                },
            trailing:
            PlayerCreditView(credits: $player.credits)
        )
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(themes: .constant(Theme()), player: .constant(Player()))
    }
}

// MARK: - EXTENSIONS

extension GameView {
    private var cardTable: some View {
        ZStack {
            Color("TableBorder")
            RoundedRectangle(cornerRadius: 40)
                .fill(themes.currentTheme)
                .padding()
        }.ignoresSafeArea()
    }
}
