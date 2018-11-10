//
//  Bot.swift
//  DuetBot
//
//  Created by ライアン on 11/10/18.
//

import Foundation
import Sword

class Bot {
    
    let sword: Sword
    let routines: [Routine]
    
    var preprocessors: [Preprocessor] {
        return routines.flatMap { $0 as? Preprocessor }
    }
    
    init(token: String, routines: Routine...) {
        sword = Sword(token: token)
        self.routines = routines
        sword.editStatus(to: "online", playing: "with Sword!")
        sword.on(.messageCreate) { [unowned self] in
            guard let command = ($0 as? Message).flatMap(Command.init) else { return }
            (self.preprocessors.first { $0.shouldIntercept(command) }?.intercept(command)
                ?? routines.first { $0 ~= command }?.observe(arguments: command.arguments))
                .map(command.respond(reply:))
        }
    }
    
    func start() {
        sword.connect()
    }
    
}
