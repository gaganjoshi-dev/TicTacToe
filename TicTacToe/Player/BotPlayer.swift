//
//  BotPlayer.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-02.
//

import Foundation

enum BotLevel: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}

class BotPlayer: Player {

    var symbol: GameSymbol
    var level: BotLevel
    var strategy: PlayingStrategy

    init(symbol: GameSymbol, level: BotLevel) {
        self.symbol = symbol
        self.level = level

        switch level {
        case .easy:
            self.strategy = EasyPlayingStrategy()
        case .medium:
            self.strategy = MediumPlayingStrategy()
        case .hard:
            self.strategy = HardPlayingStrategy()

        }

    }

    func makeMove(board: Board) -> Move {
        return strategy.play(board: board, botSymbol: symbol)
    }

}
