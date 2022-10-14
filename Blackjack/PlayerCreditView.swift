//
//  PlayerCreditView.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 10/11/22.
//

import SwiftUI

struct PlayerCreditView: View {
    @Binding var credits: Float
    
    var body: some View {
        HStack {
            Text("\(credits.clean)")
                .fontWeight(.bold)
                .animation(.linear(duration: 0.5), value: credits)
            Image(systemName: "dollarsign.circle.fill")
        }
        .font(.title3)
        .foregroundColor(Color(.white))
        .padding()
    }
}

struct PlayerCreditView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCreditView(credits: .constant(500))
            .background(Color("TableTop"))
    }
}
