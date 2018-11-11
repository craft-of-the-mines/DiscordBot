//
//  Routine.swift
//  DuetBot
//
//  Created by ライアン on 11/10/18.
//

import Foundation

func ~=(_ routine: Routine, _ command: Command) -> Bool {
    return type(of: routine).patterns.contains(command.pattern)
}

// TODO: It would be better to make a subroutine type which handle each pattern of a routine.
// Right now, there's no way for a routine to tell which part of its behavior to run. So, for
// example, `PingPongRoutine` has to be two separate routines instead of a single routine with
// different subroutines based on whether ping or pong was said.
protocol Routine: AnyObject {
    static var patterns: [String] { get }
    func observe(arguments: [String]) -> Reply
}

protocol Preprocessor: Routine {
    func shouldIntercept(_ command: Command) -> Bool
    func intercept(_ command: Command) -> Reply
}
