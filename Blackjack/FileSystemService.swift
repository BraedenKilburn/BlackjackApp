//
//  FileSystemService.swift
//  Blackjack
//
//  Created by Braeden Kilburn on 10/13/22.
//

import Foundation

struct FileSystemService {
    // Player
    func getPlayer() -> Player {
        if let jsonData = try? Data(contentsOf: fileUrl("Player")) {
            if let player = try? JSONDecoder().decode(Player.self, from: jsonData) {
                return player
            }
        }
        return Player()
    }

    func setPlayer(player: Player) {
        do {
            try save(player: player)
        } catch {
            print("Save Player Error")
        }
    }

    // Theme
    func getTheme() -> Theme {
        if let jsonData = try? Data(contentsOf: fileUrl("Theme")) {
            if let theme = try? JSONDecoder().decode(Theme.self, from: jsonData) {
                return theme
            }
        }
        return Theme()
    }

    func setTheme(theme: Theme) {
        do {
            try save(theme: theme)
        } catch {
            print("Save Theme Error")
        }
    }

    // Save
    private func save(player: Player) throws {
        if let jsonData = try? JSONEncoder().encode(player) {
            try jsonData.write(to: fileUrl("Player"), options: .atomic)
        }
    }

    private func save(theme: Theme) throws {
        if let jsonData = try? JSONEncoder().encode(theme) {
            try jsonData.write(to: fileUrl("Theme"), options: .atomic)
        }
    }

    private func fileUrl(_ key: String) throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("\(key).data")
    }
}
