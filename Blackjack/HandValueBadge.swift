//
//  HandValueBadge.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 9/29/22.
//

import SwiftUI

struct HandValueBadge: View {
    @Binding var value: Int
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(Color.orange)
                .frame(width: 30 * CGFloat(numOfDigits(for: value)), height: 45, alignment: .topTrailing)
                .position(CGPoint(x: 125, y: 0))
            Text("\(value)")
                .foregroundColor(Color.white)
                .font(Font.system(size: 35))
                .position(CGPoint(x: 125, y: 0))
        }
    }
    
    // Automatically resize the width of the capsule
    func numOfDigits(for value: Int) -> Float {
        let numOfDigits = Float(String(value).count)
        return numOfDigits == 1 ? 1.5 : numOfDigits
    }
}

struct HandValueBadge_Previews: PreviewProvider {
    static var previews: some View {
        HandValueBadge(value: .constant(12))
    }
}
