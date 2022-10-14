//
//  SoundManager.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 10/11/22.
//

import SwiftUI
import AVFoundation

class SoundManager {
    @AppStorage("isSoundOn") private var isSoundOn = true
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case win
        case lose
        case push
        case whoosh
    }
    
    func playSound(sound: SoundOption) {
        if (!isSoundOn) {
            return
        }
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else {return}
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}
