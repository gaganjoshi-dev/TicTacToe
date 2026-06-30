//
//  RandomPlayingStrategy.swift
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
        
        let cells = board.getAvailableCells()
        switch board.size {
        case 3:
            if cells.contains(where: { $0.row == 1 && $0.column == 1 }) {
                return Move(row: 1, column: 1)
            }
            let cell = cells.randomElement()
            return Move(row: cell!.row, column: cell!.column)
        default:
            let cell = cells.randomElement()
            return Move(row: cell!.row, column: cell!.column)
        }
        
        
    }
}

class HardPlayingStrategy: PlayingStrategy {
    func play(board: Board, botSymbol: GameSymbol) -> Move {
        let cell = board.getAvailableCells().randomElement()
        return Move(row: cell!.row, column: cell!.column)
    }
}
