//
//  Game.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-02.
//

import Foundation

@Observable
class Game: ObservableObject {

    var board: Board
    var players: [Player]
    var nextPlayerIndex: Int = 0
    var status: GameStatus = .inprogress
    var winner: Player?
    var statusLabel: String = ""

    init(board: Board, players: [Player]) {
        self.board = board
        self.players = players
    }

    func makeMove(move: Move) {
        guard status == .inprogress else {
            return
        }
        let player = getNextPlayer()
        apply(move: move, for: player, winStatus: .won)
    }

    func makeBotMove() {
        guard status == .inprogress else {
            return
        }
        let player = getNextPlayer()
        let move = player.makeMove(board: board)
        apply(move: move, for: player, winStatus: .lost)
    }

    @discardableResult
    private func apply(move: Move, for player: Player, winStatus: GameStatus) -> Bool {
        board.cells[move.row][move.column] = BoardCell(row: move.row, column: move.column, symbol: player.symbol)
        if checkWinner(player: player) {
            finish(status: winStatus, winner: player)
            return true
        }
        if checkDraw(player: player) {
            finish(status: .draw, winner: nil)
            return true
        }
        nextPlayerIndex = (nextPlayerIndex + 1) % players.count
        return false
    }

    private func finish(status: GameStatus, winner: Player?) {
        self.status = status
        self.statusLabel = status.rawValue
        self.winner = winner
    }

    func checkWinner(player: Player) -> Bool {
        let symbol = player.symbol
        let size = board.size
        // Check for rows and columns in a single pass
        for index in 0..<size {
            // Check row
            if board.cells[index].allSatisfy({ $0.symbol == symbol }) {
                return true
            }
            // Check column
            if (0..<size).allSatisfy({ board.cells[$0][index].symbol == symbol }) {
                return true
            }
        }
        // Check the two diagonals
        if (0..<size).allSatisfy({ board.cells[$0][$0].symbol == symbol })
            || (0..<size).allSatisfy({ board.cells[$0][size - $0 - 1].symbol == symbol }) {
            return true
        }
        return false
    }

    func checkDraw(player: Player) -> Bool {
        return board.getAvailableCells().count == 0
    }

    func getNextPlayer() -> Player {
        return players[nextPlayerIndex]
    }
}
