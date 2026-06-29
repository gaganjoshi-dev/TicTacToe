//
//  TicTacToe.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-02.
//

import SwiftUI

struct TicTacToe: View {

    @ObservedObject private var viewModel: TicTacToeViewModel
    @State var playerName: String
    @State var board: Board
    let boardSize: Int
    var players: [Player]
    init(players: [Player], boardSize: Int) {
        let board: Board = Board(size: boardSize)
        let game = Game(board: board, players: players)
        self.players = players
        self.boardSize = boardSize
        self.viewModel = TicTacToeViewModel(game: game)
        self.board = board
        playerName = (players[0] as? HumanPlayer)?.user.name ?? "User"
    }

    var body: some View {

        NavigationStack {

            Form {
                Section {
                    HStack(spacing: 20) {
                        let symbol = viewModel.game.players[0].symbol
                        symbol.image()
                            .frame(width: 30, height: 30)
                        Text(playerName)
                            .foregroundStyle(symbol.color())

                    }
                    HStack(spacing: 20) {
                        let symbol = viewModel.game.players[1].symbol
                        symbol.image()
                            .frame(width: 30, height: 30)
                        Text("Bot")
                            .foregroundStyle(symbol.color())
                    }
                }
                Section {

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: boardSize)) {
                        ForEach(0..<boardSize) { row in
                            ForEach(0..<boardSize) { column in
                                ZStack {
                                    if let symbol = viewModel.hasImageOnElement(row: row, column: column) {
                                        symbol.image()
                                        Image(systemName: "square").resizable().font(.largeTitle).frame(height: 100)
                                    } else {
                                        Image(systemName: "square").resizable().font(.largeTitle).frame(height: 100)
                                            .onTapGesture {
                                                viewModel.onTapOfBoard(row: row, column: column)
                                            }
                                    }
                                }
                            }
                        }

                    }

                }
                Section {

                    Text(viewModel.statusLabel)
                        .centerHorizontally()
                }
            }
            .navigationTitle("Tic Tac Toe")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                resetGame()
            }
        }
    }

     func resetGame() {

        let board: Board = Board(size: boardSize)
        let game = Game(board: board, players: players)

         self.viewModel.resetViewModel(game: game)

         self.board = board

         playerName = (players[0] as? HumanPlayer)?.user.name ?? "User"

    }

}

struct FadingTextView: View {
    @State private var isFadedOut = false

    var body: some View {
        Text("Your turn")
            .opacity(isFadedOut ? 0.2 : 1.0)
            .animation(.easeOut.repeatForever(), value: isFadedOut)
            .onAppear(perform: {
                isFadedOut.toggle()
            })

    }
}

#Preview {
    TicTacToe(players: [], boardSize: 4)

}

struct ElementCell: View, TableRowContent {
    var tableRowBody: Never

    typealias TableRowBody = Never

    let size: Int
    var symbol: GameSymbol?

    var body: some View {
        ZStack {
            if let symbol {
                symbol.image()
            }
            Image(systemName: "square").resizable().font(.largeTitle).frame(height: 100)

        }
    }
}
