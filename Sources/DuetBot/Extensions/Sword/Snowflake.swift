//
//  Snowflake.swift
//  DuetBot
//
//  Created by ライアン on 11/10/18.
//

import Foundation
import Sword

extension Snowflake {
    
    init?(_ string: String) {
        guard let snowflake = UInt64(string.dropFirst(2).dropLast()) else { return nil }
        self.init(snowflake)
    }
    
}
