//
//  Board.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-02.
//

import Foundation

@Observable
class Board {

    var cells: [[BoardCell]]
    var size: Int

    init(size boardSize: Int) {

        var tempCells = [[BoardCell]]()
        size = boardSize
        for row in 0..<boardSize {
            var cell = [BoardCell]()
            for column in 0..<boardSize {
                cell.append(BoardCell(row: row, column: column, symbol: nil))
            }
            tempCells.append(cell)
        }
        self.cells = tempCells

    }

    func isEmpty(row: Int, column: Int) -> Bool {
        return cells[row][column].symbol == nil

    }

    func getAvailableCells() -> [BoardCell] {

        var availableCells = [BoardCell]()

        for cellRow in cells {
            for cell in cellRow where cell.symbol == nil {
                    availableCells.append(cell)
            }
        }

        return availableCells

    }

}
