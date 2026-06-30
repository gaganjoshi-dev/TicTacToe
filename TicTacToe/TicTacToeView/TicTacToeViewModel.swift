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
    var isBotThinking = false

    private let botMoveDelay: TimeInterval = 0.6

    init(game: Game) {
        self.game = game
    }

    func resetViewModel(game: Game) {
        self.game = game
        statusLabel = GameStatus.inprogress.rawValue
        isBotThinking = false
    }

    func onTapOfBoard(row: Int, column: Int) {
        guard !isBotThinking, game.status == .inprogress else {
            return
        }
        withAnimation {
            game.makeMove(move: Move(row: row, column: column))
        }
        SoundPlayer.playMove()
        statusLabel = game.status.rawValue

        if game.status != .inprogress {
            SoundPlayer.playResult(game.status)
            return
        }
        scheduleBotMove()
    }

    private func scheduleBotMove() {
        isBotThinking = true
        DispatchQueue.main.asyncAfter(deadline: .now() + botMoveDelay) { [weak self] in
            guard let self else { return }
            withAnimation {
                self.game.makeBotMove()
            }
            SoundPlayer.playMove()
            self.statusLabel = self.game.status.rawValue
            if self.game.status != .inprogress {
                SoundPlayer.playResult(self.game.status)
            }
            self.isBotThinking = false
        }
    }

    func hasImageOnElement(row: Int, column: Int) -> GameSymbol? {
        let cells = game.board.cells
        let cell = cells[row][column]
        return cell.symbol
    }

}
