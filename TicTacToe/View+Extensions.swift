//
//  View+Extensions.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-03.
//

import Foundation
import SwiftUI

extension View {
    func centerHorizontally() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
    @ViewBuilder
    func visible(_ value: Bool) -> some View {
        // you can use if-else also
        switch value {
        case true:
            self
        case false:
            EmptyView()
        }
    }
}
