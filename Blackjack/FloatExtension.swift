//
//  FloatExtension.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 10/11/22.
//

import Foundation

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }
}
