//
//  FooterView.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 10/13/22.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Created by Braeden Kilburn")
                .foregroundColor(.gray)
                .layoutPriority(2)
            
            Text("Copyright © Braeden Kilburn\nAll rights reserved")
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .layoutPriority(1)
        } //: VSTACK
        .padding()
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
