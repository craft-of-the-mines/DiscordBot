//
//  Config.swift
//  DuetBot
//
//  Created by ライアン on 11/10/18.
//

import Foundation

struct Config: Decodable {

    let token: String
    let minecraftServer: String
    let minecraftPort: UInt16
    let minecraftPassword: String

}
