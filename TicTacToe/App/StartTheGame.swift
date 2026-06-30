//
//  StartTheGame.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-03.
//

import SwiftUI

struct StartTheGame: View {
    
    @State private var userName: String = ""
    @State private var email: String = ""
    @State private var symbol: GameSymbol = .XMark
    @State private var botSymbol: GameSymbol = .OMark
    @State private var selectedLevel: BotLevel = .easy
    
    private var isNameValid: Bool {
        !userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(spacing: 10) {
                    TextField("Enter Name: ", text: $userName)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                    TextField("Enter Email (optional): ", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
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
                        let user = User(name: userName, email: email)
                        let humanPlayer = HumanPlayer(symbol: symbol, user: user)
                        let botPlayer = BotPlayer(symbol: botSymbol, level: selectedLevel)
                        TicTacToeView(players: [humanPlayer, botPlayer])
                    } label: {
                        Text("Enter the game")
                    }
                    .centerHorizontally()
                    .disabled(!isNameValid)
                }
            }
            .navigationTitle("Start Game")
        }
    }
}

#Preview {
    StartTheGame()
}
