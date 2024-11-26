//
//  Item.swift
//  Respark
//
//  Created by Mateusz Ficek on 26/11/2024.
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
