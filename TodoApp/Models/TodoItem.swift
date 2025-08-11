//
//  TodoItem.swift
//  TodoApp
//
//  Created by 박서인 on 8/8/25.
//

import Foundation
import SwiftData

@Model
final class TodoItem {
    var id: String = UUID().uuidString
    var title: String
    var isCompleted: Bool
    var priority: Priority
    var createdAt: Date
    
    init(title: String, isCompleted: Bool = false, priority: Priority = .medium, createdAt: Date = Date()) {
        self.title = title
        self.isCompleted = isCompleted
        self.priority = priority
        self.createdAt = createdAt
    }
}
