//
//  PlaceBetView.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 10/11/22.
//

import SwiftUI

struct PlaceBetView: View {
    // MARK: - PROPERTY

    @Binding var bet: Int
    @Binding var playersCredits: Float
    @State private var timer: Timer?
    @State var isLongPressing = false
    
    private let tableMinimum: Int = 10
    private let tableMaximum: Int = 500
    private let betIncrement: Int = 10

    // MARK: - BODY

    var body: some View {
        VStack(spacing: 15) {
            // MARK: - STEPPER

            // Custom stepper for betting
            HStack {
                // Decrement Button
                Button(action: {
                    if isLongPressing {
                        isLongPressing.toggle()
                        timer?.invalidate()
                    } else {
                        bet != 0 ? bet -= betIncrement : nil
                    }
                }, label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                })
                .simultaneousGesture(LongPressGesture(minimumDuration: 0.3)
                    .onEnded { _ in
                        isLongPressing = true
                        timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true, block: { _ in
                            bet != 0 ? bet -= betIncrement : nil
                        })
                    })

                Spacer()

                // Bet Value as fixed value (if there are decimals)
                Text(String(bet))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)

                Spacer()

                // Increment Button
                Button(action: {
                    if isLongPressing {
                        isLongPressing.toggle()
                        timer?.invalidate()
                    } else {
                        bet != tableMaximum && Float(bet + betIncrement) <= playersCredits ? bet += betIncrement : nil
                    }
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                })
                .simultaneousGesture(LongPressGesture(minimumDuration: 0.3)
                    .onEnded { _ in
                        isLongPressing = true
                        timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true, block: { _ in
                            bet != tableMaximum && Float(bet + betIncrement) <= playersCredits ? bet += betIncrement : nil
                        })
                    })
            }
            .padding()
            .frame(width: 240)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray, lineWidth: 5)
            )
            .background(Color(.systemBackground))
            .cornerRadius(20)

            // MARK: - Special Buttons

            HStack(spacing: 4) {
                // All-In Button
                Button(action: {
                    if playersCredits > Float(tableMaximum) {
                        bet = tableMaximum
                    } else {
                        bet = Int(playersCredits)
                    }
                }) {
                    HStack {
                        Text("All In")
                            .foregroundColor(Color(.label))
                            .font(.title3)
                            .bold()
                        Image(systemName: "dollarsign.circle.fill")
                            .font(.title)
                            .foregroundColor(.yellow)
                    }
                }
                .frame(width: 118, height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.gray, lineWidth: 5)
                )
                .background(Color(.systemBackground))
                .cornerRadius(20)

                // Reset Button
                Button(action: { bet = 0 }) {
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                        Text("Clear")
                            .foregroundColor(Color(.label))
                            .font(.title3)
                            .bold()
                    }
                }
                .frame(width: 118, height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.gray, lineWidth: 5)
                )
                .background(Color(.systemBackground))
                .cornerRadius(20)
            }

            // Text to explain that the table minimum is 10 and the table maximum is 500
            VStack {
                Text("Table Minimum: $10")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                Text("Table Maximum: $500")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            }
        }
    }
}

// MARK: - PREVIEW

struct PlaceBetView_Previews: PreviewProvider {
    // Preview that updates with the bet value
    @State static var bet: Int = 100
    @State static var playersCredits: Float = 200

    static var previews: some View {
        ZStack {
            Color("GreenTableTop")
            PlaceBetView(bet: $bet, playersCredits: $playersCredits)
        }
        .ignoresSafeArea()
    }
}
