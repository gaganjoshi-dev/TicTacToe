//
//  Player.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-02.
//

import Foundation

protocol Player {
    var symbol: GameSymbol { get set }
    func makeMove(board: Board) -> Move
}
