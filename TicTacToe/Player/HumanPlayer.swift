//
//  HumanPlayer.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-02.
//

import Foundation

class HumanPlayer: Player {
    var symbol: GameSymbol

    var user: User

    init(symbol: GameSymbol, user: User) {
        self.symbol = symbol
        self.user = user
    }

    func makeMove(board: Board) -> Move {
        return Move(row: 0, column: 0)
    }

}
