//
//  TicTacToe.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-02.
//

import SwiftUI

struct TicTacToe: View {
    @State private var viewModel: TicTacToeViewModel
    let boardSize: Int = 3
    var players: [Player]
    
    private var playerName: String {
        (players.first as? HumanPlayer)?.user.name ?? "User"
    }
    
    init(players: [Player]) {
        let board = Board(size: boardSize)
        let game = Game(board: board, players: players)
        self.players = players
        self.viewModel = TicTacToeViewModel(game: game)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    PlayerRow(
                        symbol: viewModel.game.players[0].symbol,
                        name: playerName
                    )
                    PlayerRow(
                        symbol: viewModel.game.players[1].symbol,
                        name: "Bot"
                    )
                }
                Section {
                    
                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(.flexible()),
                            count: boardSize
                        )
                    ) {
                        ForEach(0..<3) { row in
                            ForEach(0..<3) { column in
                                let symbol = viewModel.hasImageOnElement(
                                    row: row,
                                    column: column
                                )
                                ZStack {
                                    if let symbol {
                                        symbol.image()
                                    }
                                    Image(systemName: "square")
                                        .resizable()
                                        .font(.largeTitle)
                                        .frame(height: 100)
                                }
                                .onTapGesture {
                                    if symbol == nil {
                                        viewModel
                                            .onTapOfBoard(
                                                row: row,
                                                column: column
                                            )
                                    }
                                }
                            }
                        }
                        
                    }
                }
                Section {
                    
                    Text(viewModel.statusLabel)
                        .centerHorizontally()
                    
                    Button("New Game") {
                        resetGame()
                    }
                    .centerHorizontally()
                }
            }
            .navigationTitle("Tic Tac Toe")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func resetGame() {
        let board = Board(size: boardSize)
        let game = Game(board: board, players: players)
        viewModel.resetViewModel(game: game)
    }
    
    
    
}

struct PlayerRow: View {
    var symbol: GameSymbol
    var name: String
    
    var body: some View {
        HStack(spacing: 20) {
            symbol.image()
                .frame(width: 30, height: 30)
            Text(name)
                .foregroundStyle(symbol.color())
        }
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
    TicTacToe(players: [])
}
