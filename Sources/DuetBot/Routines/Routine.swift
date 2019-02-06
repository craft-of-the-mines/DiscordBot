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
    // NOTE: Here's where the major defect is. Right now, this only allows a routine
    // to match against explicitly-defined patterns. You kind of want an ADT/discriminated
    // union here so that you can still represent explicit keywords but also the catch-all
    // case. With this functionality, your minecraft message function would match against
    // any incoming "command". See the note below about what happens after the messaging
    // routine matches.
    static var patterns: [String] { get }
    // NOTE: This should probably just take the entire command as an argument.
    // Commands should store the raw text too. This way, your routines can be
    // more flexible about the incoming data and optionally use the convenience
    // properties (i.e. Command.arguments) to make the code cleaner.
    // e.g. observe(command: Command)
    func observe(arguments: [String]) -> Reply
}

protocol Preprocessor: Routine {
    func shouldIntercept(_ command: Command) -> Bool
    func intercept(_ command: Command) -> Reply
}
