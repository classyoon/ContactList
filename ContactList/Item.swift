//
//  Item.swift
//  ContactList
//
//  Created by Conner Yoon on 5/27/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
