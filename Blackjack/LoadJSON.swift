//
//  LoadJSON.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 9/28/22.
//

import Foundation

// This is a function that loads a JSON file from the app bundle and returns it as an array of cards
func loadJson(withFilename fileName: String) -> [Card]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let cards = try decoder.decode([Card].self, from: data)
            return cards
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}
