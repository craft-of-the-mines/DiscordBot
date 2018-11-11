//
//  MinecraftMessageRoutine.swift
//  DuetBot
//
//  Created by Tyler Rister on 11/10/18.
//

import Sword
import Foundation
import Raptor

class Wraptor {

    private let srcon: UnsafeMutableRawPointer

    init(ip: String, port: Int, password: String) {
        ip.withCString { ip in
            password.withCString { password in
                self.srcon = srcon_create(UnsafeMutablePointer(mutating: ip), port, UnsafeMutablePointer(mutating: password))
            }
        }
    }

    func send(message: String) {
        message.withCString { srcon_send(srcon, UnsafeMutablePointer(mutating: $0), 2) }
    }

}

class MinecraftMessageRoutine: Routine {

    static var patterns: [String] {
        return ["mc-message"]
    }

    let ip: String
    let port: UInt16
    let password: String

    init(_ ip: String, _ port: UInt16, _ password: String) {
      self.ip = ip
      self.port = port
      self.password = password
    }

    func observe(arguments: [String]) -> Reply {
        Wraptor(ip: "", port: 23, password: "")
            .send(message: "ho")
      let serverC = ip.cString(using: String.defaultCStringEncoding)!
      let newServer = NSString(bytes: serverC, length: Int(ip.characters.count), encoding:String.Encoding.ascii.rawValue)! as String
      let serverPointer = UnsafeMutablePointer<Int8>(newServer)
      let passwordC = password.cString(using: String.defaultCStringEncoding)!
      let newPassword = NSString(bytes: passwordC, length: Int(password.characters.count), encoding:String.Encoding.ascii.rawValue)! as String
//      let passwordPointer = UnsafeMutablePointer<Int8>(newPassword)
      let message = "tellraw @a [{\"color\": \"white\", \"text\": \"Hi\"}]"
      let messageC = message.cString(using: String.defaultCStringEncoding)!
      let newMessage = NSString(bytes: messageC, length: Int(message.characters.count), encoding:String.Encoding.ascii.rawValue)! as String
//      let messagePointer = UnsafeMutablePointer<Int8>(newMessage)
      let raptor = srcon_create(serverPointer, 25575, passwordPointer)
      srcon_send(raptor, messagePointer)
      return nil
    }



}
