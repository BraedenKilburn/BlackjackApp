//
//  SettingsView.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 10/13/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero

    @Binding var player: Player
    @Binding var themes: Theme

    @State private var isAlerting: Bool = false
    @State private var isAnimating: Bool = false

    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isSoundOn") private var isSoundOn = true

    var body: some View {
        ZStack {
            Image("LaunchIcon")
                .resizable()
                .scaledToFit()
                .opacity(isDarkMode ? 0.5 : 0.2)

            VStack(spacing: 20) {
                HStack {
                    Text("Settings")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }

                HStack {
                    Text("Preferences")
                        .font(.title2)
                        .fontWeight(.medium)
                    Spacer()
                }

                // Dark Mode Toggle with Icon
                HStack {
                    Image(systemName: "moon.fill")
                        .foregroundColor(isDarkMode ? .yellow : .gray)
                    Toggle("Dark Mode", isOn: $isDarkMode)
                        .toggleStyle(SwitchToggleStyle(tint: .yellow))
                }

                // Sound Toggle with Icon
                HStack {
                    Image(systemName: "speaker.wave.3.fill")
                        .foregroundColor(isSoundOn ? .green : .gray)
                    Toggle("Sound", isOn: $isSoundOn)
                        .toggleStyle(SwitchToggleStyle(tint: .green))
                }

                Spacer()

                Button("Reset Game") {
                    isAlerting = true
                }
                .alert(isPresented: $isAlerting) {
                    Alert(
                        title: Text("Reset Game"),
                        message: Text("Are you sure you want to reset the game? This will reset your credits and themes."),
                        primaryButton: .destructive(Text("Reset")) {
                            player = Player()
                            themes = Theme()
                            FileSystemService().setPlayer(player: player)
                            FileSystemService().setTheme(theme: themes)
                        },
                        secondaryButton: .cancel()
                    )
                }
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .background(.red)
                .cornerRadius(8)

                FooterView()
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(
            leading:
            Button(action: { self.mode.wrappedValue.dismiss()
            }) {
                NavbarBackButton(color: Color(.label), noPadding: true)
            }
        )
        .gesture(DragGesture().updating($dragOffset, body: { value, _, _ in
            if value.startLocation.x < 20, value.translation.width > 100 {
                self.mode.wrappedValue.dismiss()
            }
        }))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(player: .constant(Player()), themes: .constant(Theme()))
    }
}
