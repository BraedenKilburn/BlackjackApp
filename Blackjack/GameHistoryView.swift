//
//  GameHistoryView.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 10/13/22.
//

import SwiftUI

struct GameHistoryView: View {
    // MARK: - PROPERTIES

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero

    @State private var isAnimating: Bool = false
    @Binding var player: Player

    // MARK: - BODY

    var body: some View {
        ZStack {
            Color("LaunchScreenBackground")
                .ignoresSafeArea()

            VStack(spacing: 10) {
                Text("Game History")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    .opacity(isAnimating ? 1 : 0)

                Image("LaunchIcon")
                    .resizable()
                    .scaledToFit()
                    .offset(y: isAnimating ? 0 : -40)

                // Display the player's total credits
                VStack(spacing: 20) {
                    HStack {
                        Text("Total Available Credits:")
                        Spacer()
                        Text(player.credits.clean)
                    }
                    HStack {
                        Text("Total Credits Won:")
                        Spacer()
                        Text(player.totalCreditsWon.clean)
                    }
                    HStack {
                        Text("Total Credits Lost:")
                        Spacer()
                        Text(player.totalCreditsLost.clean)
                    }
                }
                .padding()
                .font(.title3)
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .background(.white.opacity(0.4))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.black, lineWidth: 5)
                )
                .padding()
                .offset(x: isAnimating ? 0 : 1000)

                VStack(spacing: 20) {
                    // Games won
                    HStack {
                        Text("Hands Won:")
                        Spacer()
                        Text(player.totalWins.description)
                    }

                    // Games lost
                    HStack {
                        Text("Hands Lost:")
                        Spacer()
                        Text(player.totalLosses.description)
                    }

                    // Games tied
                    HStack {
                        Text("Hands Tied:")
                        Spacer()
                        Text(player.totalPushes.description)
                    }

                    // Games played
                    HStack {
                        Text("Total Hands Played:")
                        Spacer()
                        Text(player.totalGames.description)
                    }
                }
                .padding()
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .background(.white.opacity(0.4))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.black, lineWidth: 5)
                )
                .padding()
                .offset(x: isAnimating ? 0 : -1000)

                Spacer()
            }
            .animation(.easeOut(duration: 1), value: isAnimating)
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(
            leading:
            Button(action: { self.mode.wrappedValue.dismiss()
            }) {
                NavbarBackButton()
            }
        )
        .gesture(DragGesture().updating($dragOffset, body: { value, _, _ in
            if value.startLocation.x < 20, value.translation.width > 100 {
                self.mode.wrappedValue.dismiss()
            }
        }))
        .onAppear {
            isAnimating = true
        }
    }
}

// MARK: - PREVIEW

struct GameHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        GameHistoryView(player: .constant(Player(totalWins: 10, totalLosses: 20, totalPushes: 2)))
    }
}
