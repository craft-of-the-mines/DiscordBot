//
//  LanguageRoutine.swift
//  DuetBot
//
//  Created by ライアン on 11/10/18.
//

import Foundation

class Strings {
    
    private static var tables = [String: [String: String]]()
    
    static func string(keyed key: String, in table: String, `default`: String? = nil) -> String {
        return load(tableName: table)[key] ?? `default` ?? key
    }
    
    
    private static func load(tableName: String) -> [String: String] {
        let url = URL(fileURLWithPath: FileManager.default.currentDirectoryPath.appending("/\(tableName).plist"))
        let table = NSDictionary(contentsOf: url).flatMap { $0 as? [String: String] } ?? [:]
        tables[tableName] = table
        return table
    }
    
    private init() { }
    
}

func DBString(_ key: String) -> String {
    return Strings.string(keyed: key, in: LanguageRoutine.isRude ? "rude" : "tame")
}

class LanguageRoutine: Routine {
    
    fileprivate static var isRude = false
    
    static var patterns: [String] {
        return ["lang"]
    }
    
    func observe(arguments: [String]) -> Reply {
        guard arguments.count == 1 else { return "Specify just 'tame' or 'rude'." }
        switch arguments[0] {
        case "tame":
            type(of: self).isRude = false
            return "Aww...I was having fun!"
        case "rude":
            type(of: self).isRude = true
            return ":smiling_imp:"
        default: return "Specify either 'tame' or 'rude'."
        }
    }
    
    
    
    
}
