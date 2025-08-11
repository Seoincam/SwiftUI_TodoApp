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
    var dueDate: Date?
    var createdAt: Date
    
    init(title: String,
         isCompleted: Bool = false,
         priority: Priority = .medium,
         dueDate: Date? = nil,
         createdAt: Date = Date()) {
        self.title = title
        self.isCompleted = isCompleted
        self.priority = priority
        self.dueDate = dueDate
        self.createdAt = createdAt
    }
}
