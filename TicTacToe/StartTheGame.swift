//
//  StartTheGame.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-03.
//

import SwiftUI

enum BoardSize: Int, CaseIterable {
    case normal = 3
    case large = 4
    case max = 5

    var description: String {
        switch self {
        case .normal:
            return "Normal"
        case .large:
            return "Large"
        case .max:
            return "Max"
        }
    }
}

struct StartTheGame: View {

    @State private var userName: String = ""
    @State private var email: String = ""
    @State private var symbol: GameSymbol = .XMark
    @State private var botSymbol: GameSymbol = .OMark
    @State private var selectedBoardSize: BoardSize = .normal
    @State private var selectedLevel: BotLevel = .easy

    var body: some View {

        NavigationStack {

            Form {
                HStack(spacing: 10) {
                    Image(systemName: "person")
                        .resizable().frame(width: 80, height: 80)
                    VStack(spacing: 10) {
                        TextField("Enter Name: ", text: $userName).textFieldStyle(.roundedBorder)
                        TextField("Enter Email: ", text: $email).textFieldStyle(.roundedBorder)
                    }
                }

                Section(header: Text("Select your symbol")) {
                    Picker("Select", selection: $symbol) {
                        GameSymbol.XMark.image()
                            .tag(GameSymbol.XMark)
                        GameSymbol.OMark.image()
                            .tag(GameSymbol.OMark)
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: symbol, { oldValue, _ in
                        botSymbol = oldValue
                    })
                }
                Section(header: Text("Select Board Size")) {

                        Picker("Select Board Size", selection: $selectedBoardSize) {
                            ForEach(BoardSize.allCases, id: \.self) { size in
                                Text(size.description).tag(size)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())

                }
                Section(header: Text("Choose Game Level")) {

                        Picker("Choose Game Level", selection: $selectedLevel) {
                            ForEach(BotLevel.allCases, id: \.self) { level in
                                Text(level.rawValue).tag(level)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())

                }

                Section {

                    NavigationLink {

                        let user = User(name: userName, email: email, image: "")
                        let humanPlayer = HumanPlayer(symbol: symbol, user: user)
                        let botPlayer = BotPlayer(symbol: botSymbol, level: selectedLevel)
                        // goTicTacToe()
                        TicTacToe(players: [humanPlayer, botPlayer], boardSize: selectedBoardSize.rawValue)

                    } label: {
                        Text("Enter the game")
                    }.centerHorizontally()

                }
            }
            .navigationTitle("Start Game")

        }

    }
}

#Preview {
    StartTheGame()
}
