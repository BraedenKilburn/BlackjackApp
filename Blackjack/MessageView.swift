//
//  MessageView.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 10/3/22.
//

import SwiftUI

struct MessageView: View {
    @Binding var message: String

    var body: some View {
        Text(message)
            .frame(width: 250)
            .multilineTextAlignment(.center)
            .font(.system(size: 18, weight: .heavy))
            .foregroundColor(.white)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: .constant("Hello World"))
            .background(.black)
    }
}
