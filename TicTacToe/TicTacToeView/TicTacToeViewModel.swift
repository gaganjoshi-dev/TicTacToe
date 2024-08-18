//
//  TicTacToeViewModel.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-04.
//

import Foundation
import SwiftUI

@Observable
class TicTacToeViewModel: ObservableObject {

    var game: Game
    var statusLabel: String = GameStatus.inprogress.rawValue

    var boardSize: Int {
        return game.board.size
    }

    init(game: Game) {
        self.game = game
    }

    func resetViewModel(game: Game) {
        self.game = game
        statusLabel = GameStatus.inprogress.rawValue
    }
    
    func onTapOfBoard(row: Int, column: Int) {
        print("row = \(row)", "column = \(column)")
        game.makeMove(move: Move(row: row, column: column))
        statusLabel = game.status.rawValue
    }

    func hasImageOnElement(row: Int, column: Int) -> GameSymbol? {
        let cells = game.board.cells
        let cell = cells[row][column]
        return cell.symbol
    }

}
