//
//  User.swift
//  TicTacToe
//
//  Created by gagan joshi on 2024-01-02.
//

import Foundation
import SwiftUI

class User {

    var name: String
    var email: String
    var image: String

    init(name: String, email: String, image: String) {
        self.name = name
        self.email = email
        self.image = image
    }
}
