//
//  NavbarBackButton.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 10/11/22.
//

import SwiftUI

struct NavbarBackButton: View {
    // MARK: - PROPERTY

    @State var message: String = "Back"
    @State var color: Color = .white
    @State var noPadding: Bool = false

    // MARK: - BODY

    var body: some View {
        HStack {
            Image(systemName: "chevron.backward.circle.fill")
            Text(message)
                .fontWeight(.bold)
        }
        .font(.title3)
        .padding(noPadding ? 0 : 10)
        .foregroundColor(color)
    }
}

// MARK: - PREVIEW

struct LeaveTableView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarBackButton()
            .background(Color("TableTop"))
    }
}
