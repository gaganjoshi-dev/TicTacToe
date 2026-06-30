//
//  SoundPlayer.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-04.
//

import AudioToolbox

enum SoundPlayer {

    static func playMove() {
        AudioServicesPlaySystemSound(1104)
    }

    static func playResult(_ status: GameStatus) {
        switch status {
        case .won:
            AudioServicesPlaySystemSound(1025)
        case .lost:
            AudioServicesPlaySystemSound(1053)
        case .draw:
            AudioServicesPlaySystemSound(1103)
        case .inprogress:
            break
        }
    }
}
