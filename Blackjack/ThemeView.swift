//
//  ThemeView.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 10/12/22.
//

import SwiftUI

struct ThemeView: View {
    // MARK: - PROPERTY

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero

    @State private var isAnimating: Bool = false
    @State private var showingAlert: Bool = false
    @State private var alertTitle: String = "Insufficient Funds"
    @State private var alertMessage: String = "You need 250 credits to unlock this theme."
    @State private var insufficientFunds: Bool = true
    @State private var selectedColor: Color = .greenTableTop
    @State private var unlockCost: Float = 250

    @Binding var themes: Theme
    @Binding var player: Player

    // MARK: - BODY

    var body: some View {
        ZStack {
            Color("LaunchScreenBackground")
                .ignoresSafeArea()

            VStack(spacing: 30) {
                // Title
                Text("Theme Store")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .opacity(isAnimating ? 1 : 0)

                Text("These are the themes you can choose from, they will change the color of the table top.\nEach theme costs \(unlockCost.clean) credits.")
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .opacity(isAnimating ? 1 : 0)

                // For each theme in the theme array, create a button
                ForEach(themes.getAll(), id: \.self) { color in
                    Button(action: {
                        selectedColor = color
                        setTheme(color)
                    }, label: {
                        // Create a button with the color of the theme
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(color)
                                .frame(width: 100, height: 100)
                                .shadow(color: color == themes.currentTheme ? .white : .black, radius: 5)

                            // If the theme is locked, show a lock
                            if themes.locked.contains(color) {
                                Image(systemName: "lock.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                            } else if color == themes.currentTheme {
                                // If the theme is unlocked and selected, show a checkmark in the top right corner
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 20))
                                    .offset(x: 30, y: -30)
                                    .foregroundColor(.white)
                            }
                        }
                    })
                    .offset(y: isAnimating ? 0 : 500)
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text(alertTitle),
                            message: Text(alertMessage),
                            primaryButton: insufficientFunds ? .default(Text("OK")) : .default(Text("Unlock")) {
                                purchaseTheme(selectedColor)
                            },
                            secondaryButton: .cancel(Text("Cancel"))
                        )
                    }
                }
            }
            .padding()
            .animation(.easeOut(duration: 1), value: isAnimating)
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(
            leading:
            Button(action: { self.mode.wrappedValue.dismiss()
            }) {
                NavbarBackButton()
            },
            trailing:
            PlayerCreditView(credits: $player.credits)
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

    func setTheme(_ color: Color) {
        if themes.isUnlocked(color) {
            // Set the current theme to the color of the button
            themes.setCurrentTheme(color)
            FileSystemService().setTheme(theme: themes)
        } else {
            if player.credits >= unlockCost {
                insufficientFunds = false
                alertTitle = "Unlock Theme?"
                alertMessage = "Unlocking this theme will cost \(unlockCost.clean) credits."
            }
            showingAlert = true
        }
    }

    func purchaseTheme(_ color: Color) {
        // Remove the theme from the locked array
        themes.unlock(color)
        // Remove the cost of the theme from the player's credits
        player.credits -= unlockCost
        // Set the current theme to the color of the button
        setTheme(color)
        // Update state
        FileSystemService().setTheme(theme: themes)
        FileSystemService().setPlayer(player: player)
    }
}

// MARK: - PREVIEW

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(themes: .constant(Theme()), player: .constant(Player()))
    }
}
