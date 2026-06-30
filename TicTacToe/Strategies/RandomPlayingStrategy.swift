//
//  RandomPlayingStrategy.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-03.
//

import Foundation

/// Easy: picks a random available cell.
class EasyPlayingStrategy: PlayingStrategy {
    func play(board: Board, botSymbol: GameSymbol) -> Move {
        let grid = board.symbolGrid()
        return availableMoves(in: grid).randomElement() ?? Move(row: 0, column: 0)
    }
}

/// Medium: takes a winning move if available, otherwise blocks the
/// opponent's winning move, otherwise plays randomly.
class MediumPlayingStrategy: PlayingStrategy {
    func play(board: Board, botSymbol: GameSymbol) -> Move {
        let grid = board.symbolGrid()
        let opponent = botSymbol.toggle()
        let moves = availableMoves(in: grid)

        if let winning = winningMove(for: botSymbol, in: grid, moves: moves) {
            return winning
        }
        if let block = winningMove(for: opponent, in: grid, moves: moves) {
            return block
        }
        return moves.randomElement() ?? Move(row: 0, column: 0)
    }
}

/// Hard: unbeatable play using the minimax algorithm.
class HardPlayingStrategy: PlayingStrategy {
    func play(board: Board, botSymbol: GameSymbol) -> Move {
        var grid = board.symbolGrid()
        let opponent = botSymbol.toggle()

        var bestScore = Int.min
        var bestMove: Move?
        for move in availableMoves(in: grid) {
            grid[move.row][move.column] = botSymbol
            let score = minimax(
                grid,
                depth: 0,
                isMaximizing: false,
                botSymbol: botSymbol,
                opponent: opponent
            )
            grid[move.row][move.column] = nil
            if score > bestScore {
                bestScore = score
                bestMove = move
            }
        }
        return bestMove ?? (availableMoves(in: grid).first ?? Move(row: 0, column: 0))
    }
}

// MARK: - Shared helpers

private func availableMoves(in grid: [[GameSymbol?]]) -> [Move] {
    var moves = [Move]()
    for row in grid.indices {
        for column in grid[row].indices where grid[row][column] == nil {
            moves.append(Move(row: row, column: column))
        }
    }
    return moves
}

/// Returns the first move from `moves` that immediately wins for `symbol`.
private func winningMove(for symbol: GameSymbol, in grid: [[GameSymbol?]], moves: [Move]) -> Move? {
    for move in moves {
        var candidate = grid
        candidate[move.row][move.column] = symbol
        if isWinner(symbol, in: candidate) {
            return move
        }
    }
    return nil
}

private func isWinner(_ symbol: GameSymbol, in grid: [[GameSymbol?]]) -> Bool {
    let size = grid.count
    for index in 0..<size {
        if (0..<size).allSatisfy({ grid[index][$0] == symbol }) { return true }
        if (0..<size).allSatisfy({ grid[$0][index] == symbol }) { return true }
    }
    if (0..<size).allSatisfy({ grid[$0][$0] == symbol }) { return true }
    if (0..<size).allSatisfy({ grid[$0][size - $0 - 1] == symbol }) { return true }
    return false
}

private func minimax(
    _ grid: [[GameSymbol?]],
    depth: Int,
    isMaximizing: Bool,
    botSymbol: GameSymbol,
    opponent: GameSymbol
) -> Int {
    if isWinner(botSymbol, in: grid) { return 10 - depth }
    if isWinner(opponent, in: grid) { return depth - 10 }

    let moves = availableMoves(in: grid)
    if moves.isEmpty { return 0 }

    if isMaximizing {
        var best = Int.min
        for move in moves {
            var next = grid
            next[move.row][move.column] = botSymbol
            best = max(best, minimax(next, depth: depth + 1, isMaximizing: false, botSymbol: botSymbol, opponent: opponent))
        }
        return best
    } else {
        var best = Int.max
        for move in moves {
            var next = grid
            next[move.row][move.column] = opponent
            best = min(best, minimax(next, depth: depth + 1, isMaximizing: true, botSymbol: botSymbol, opponent: opponent))
        }
        return best
    }
}
