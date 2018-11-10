//
//  InsultRoutine.swift
//  DuetBot
//
//  Created by ライアン on 11/10/18.
//

import Foundation

class InsultRoutine: Preprocessor {
    
    static var patterns: [String] {
        return ["insult", "snub"]
    }
    
    private(set) var insultedUsers: [String]
    
    init(ignoring users: [String]) {
        self.insultedUsers = users
    }
    
    func shouldIntercept(_ command: Command) -> Bool {
        return command.sender?.username.map(insultedUsers.contains) ?? false
    }
    
    func intercept(_ command: Command) -> Reply {
        return "Hey, screw you\(command.sender?.username.map { " \($0)" } ?? "")!"
    }
    
    func observe(arguments: [String]) -> Reply {
        insultedUsers.append(contentsOf: arguments)
        switch arguments.count {
        case 0:
            return "Ya gotta tell me who to target!"
        case 1:
            return "Okay, whenever \(arguments[0]) tries to message me they'll regret it!"
        case 2:
            return "Okay, whenever \(arguments[0]) or \(arguments[1]) try to message me they'll regret it!"
        default:
            let targets = arguments
                .dropLast()
                .joined(separator: ", ")
                .appending(", or \(arguments.last!)")
            return "Okay, whenever \(targets) try to message me they'll regret it!"
        }
    }
    
    
    
}
