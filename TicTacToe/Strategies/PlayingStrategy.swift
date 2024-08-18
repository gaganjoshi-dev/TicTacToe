//
//  PlayingStrategy.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-02.
//

import Foundation

protocol PlayingStrategy {
    func play(board: Board, botSymbol: GameSymbol) -> Move
}
