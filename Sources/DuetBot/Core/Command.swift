//
//  Command.swift
//  DuetBot
//
//  Created by ライアン on 11/10/18.
//

import Foundation
import Sword

// NOTE: If there are more ways to reply than just with a message, turn
// reply into a real type and return that instead.
typealias Reply = String

struct Command {
    
    let pattern: String
    let arguments: [String]
    private let message: Message
    
    var sender: User? {
        return message.author
    }
    
    init?(_ message: Message) {
        self.message = message
        guard message.content.hasPrefix("!") else { return nil }
        let components = message.content.dropFirst().components(separatedBy: " ")
        guard components.count > 0 else { return nil }
        pattern = components[0].lowercased()
        arguments = Array(components.dropFirst())
    }
    
    func respond(reply: Reply) {
        message.reply(with: reply)
    }
    
}
