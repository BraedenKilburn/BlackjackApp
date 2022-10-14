//
//  CardView.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 10/4/22.
//

import SwiftUI

struct CardView: View {
    var location: String

    var body: some View {
        Image(location)
            .resizable()
            .frame(width: 130, height: 200)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(location: "ace_of_hearts")
    }
}
