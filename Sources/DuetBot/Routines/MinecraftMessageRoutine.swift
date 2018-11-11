//
//  MinecraftMessageRoutine.swift
//  DuetBot
//
//  Created by Tyler Rister on 11/10/18.
//

import Sword
import Foundation
import Raptor

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
      print(ip)
      print(port)
      print(password)
      let serverC = stringToUnsafeMutablePointer(message: ip)
      let passwordC = stringToUnsafeMutablePointer(message: password)
      let message = "tellraw @a [{\"color\": \"white\", \"text\": \"Hi\"}]"
      let messageC = stringToUnsafeMutablePointer(message: message)
      let raptor = srcon_create(serverC, 25575, passwordC)
      srcon_send(raptor, messageC, 2)
      return nil
    }

    func stringToUnsafeMutablePointer(message: String) -> UnsafeMutablePointer<Int8> {
        var messageCString = message.utf8CString
        return messageCString.withUnsafeMutableBytes { mesUMRBP in
            return mesUMRBP.baseAddress!.bindMemory(to: Int8.self, capacity: mesUMRBP.count)
        }

    }

}
