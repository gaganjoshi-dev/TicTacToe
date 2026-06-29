//
//  Cell.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-02.
//

import Foundation

class BoardCell {

    var row: Int
    var column: Int
    var symbol: GameSymbol?

    init(row: Int, column: Int, symbol: GameSymbol?) {
        self.row = row
        self.column = column
        self.symbol = symbol
    }
}
