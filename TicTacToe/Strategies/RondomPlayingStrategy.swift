//
//  RondomPlayingStrategy.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-03.
//

import Foundation

class EasyPlayingStrategy: PlayingStrategy {
    func play(board: Board, botSymbol: GameSymbol) -> Move {
        let cell = board.getAvailableCells().randomElement()
        return Move(row: cell!.row, column: cell!.column)
    }
}

class MediumPlayingStrategy: PlayingStrategy {
    func play(board: Board, botSymbol: GameSymbol) -> Move {
        let cell = board.getAvailableCells().randomElement()
        return Move(row: cell!.row, column: cell!.column)
    }
}

class HardPlayingStrategy: PlayingStrategy {
    func play(board: Board, botSymbol: GameSymbol) -> Move {
        let cell = board.getAvailableCells().randomElement()
        return Move(row: cell!.row, column: cell!.column)
    }
}
