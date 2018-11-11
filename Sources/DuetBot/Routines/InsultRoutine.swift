//
//  InsultRoutine.swift
//  DuetBot
//
//  Created by ライアン on 11/10/18.
//

import Sword
import Foundation

extension Snowflake {
    
    init?(_ string: String) {
        guard let snowflake = UInt64(string.dropFirst(2).dropLast()) else { return nil }
        self.init(snowflake)
    }
    
}

class InsultRoutine: Preprocessor {
    
    static var patterns: [String] {
        return ["insult", "snub"]
    }

    enum Target {
        case username(String)
        case snowflake(Snowflake)
    }
    
    private(set) var insultedUsers: [Target]
    
    init(ignoring users: [String]) {
        self.insultedUsers = users.map(Target.username)
    }
    
    func shouldIntercept(_ command: Command) -> Bool {
        guard let user = command.sender else { return false }
        return insultedUsers.contains {
            switch $0 {
            case .username(let username): return user.username == username
            case .snowflake(let snowflake): return user.id == snowflake
            }
        }
    }
    
    func intercept(_ command: Command) -> Reply {
        return "Hey, screw you\(command.sender?.username.map { " \($0)" } ?? "")!"
    }
    
    func observe(arguments: [String]) -> Reply {
        let targets = arguments.map { Snowflake($0).map(Target.snowflake) ?? Target.username($0) }
        insultedUsers.append(contentsOf: targets)
        switch arguments.count {
        case 0:
            return "Ya gotta tell me who to target!"
        case 1:
            return "Okay, whenever \(arguments[0]) tries to message me they'll regret it!"
        case 2:
            return "Okay, whenever \(arguments[0]) or \(arguments[1]) try to message me they'll regret it!"
        default:
            let targetNames = arguments
                .dropLast()
                .joined(separator: ", ")
                .appending(", or \(arguments.last!)")
            return "Okay, whenever \(targetNames) try to message me they'll regret it!"
        }
    }
    
    
    
}
