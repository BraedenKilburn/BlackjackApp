//
//  HomePage.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 10/3/22.
//

import SwiftUI

struct HomePage: View {
    // MARK: - PROPERTY

    @State private var isAnimating: Bool = false
    @State var player = FileSystemService().getPlayer()
    @State var themes = FileSystemService().getTheme()

    // MARK: - BODY

    var body: some View {
        NavigationView {
            ZStack {
                Color("LaunchScreenBackground")
                    .ignoresSafeArea()

                VStack {
                    Spacer()
                    Image("LaunchIcon")
                        .offset(y: isAnimating ? 0 : -40)
                    Spacer()
                    VStack(spacing: 20) {
                        NavigationLink("Start Game", destination: GameView(
                            themes: $themes, player: $player))
                            .withMenuStyles()
                            .offset(x: isAnimating ? 0 : 200)
                        NavigationLink("Game History", destination: GameHistoryView(player: $player))
                            .withMenuStyles()
                            .offset(x: isAnimating ? 0 : 300)
                        NavigationLink("Themes", destination: ThemeView(themes: $themes, player: $player))
                            .withMenuStyles()
                            .offset(x: isAnimating ? 0 : 400)
                        NavigationLink("Settings", destination: SettingsView(player: $player, themes: $themes))
                            .withMenuStyles()
                            .offset(x: isAnimating ? 0 : 500)
                    }
                    Spacer()
                }
                .opacity(isAnimating ? 1 : 0)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }
            .onAppear {
                isAnimating = true
            }
        }
    }
}

// MARK: - PREVIEW

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
