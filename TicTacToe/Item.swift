//
//  Item.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-02.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date

    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
