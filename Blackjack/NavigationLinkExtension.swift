//
//  ButtonExtension.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 10/11/22.
//

import SwiftUI

extension NavigationLink {
    func withMenuStyles() -> some View {
        self.buttonStyle(AnimatedButton())
    }
}

struct AnimatedButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .bold()
            .font(.title3)
            .foregroundColor(Color(.label))
            .frame(width: 200, height: 50)
            .background(configuration.isPressed ? Color(.systemBackground).opacity(0.5) : Color(.systemBackground))
            .cornerRadius(10)
            .shadow(radius: 10)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct ButtonExtension_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("LaunchScreenBackground")
                .ignoresSafeArea()
            
            NavigationLink("Button", destination: {})
                .withMenuStyles()
        }
    }
}
