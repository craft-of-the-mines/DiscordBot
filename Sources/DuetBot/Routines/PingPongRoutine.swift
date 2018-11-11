//
//  PingPongRoutine.swift
//  DuetBot
//
//  Created by ライアン on 11/10/18.
//

import Foundation

class PingRoutine: Routine {
    
    static var patterns: [String] {
        return ["ping"]
    }
    
    func observe(arguments: [String]) -> Reply {
        return "Pong!"
    }
    
}

class PongRoutine: Routine {
    
    static var patterns: [String] {
        return ["pong"]
    }
    
    func observe(arguments: [String]) -> Reply {
        return "Ping!"
    }
    
}
