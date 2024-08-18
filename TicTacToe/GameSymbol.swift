//
//  Symbol.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-02.
//

import Foundation
import SwiftUI

enum GameSymbol: String {
    case XMark = "X"
    case OMark = "O"

    func image() -> some View {
        switch self {
        case .XMark:
            return  Image(systemName: "x.square")
                      .resizable()
                      .foregroundColor(.blue)
        case .OMark:
            return  Image(systemName: "circle.square")
                      .resizable()
                      .foregroundColor(.pink)
        }
    }

    func color() -> Color {
        switch self {
        case .XMark:
            return  .blue
        case .OMark:
            return  .pink
        }
    }
    func toggle() -> GameSymbol {
        switch self {
        case .XMark:
            return  .OMark
        case .OMark:
            return  .XMark
        }
    }

}
