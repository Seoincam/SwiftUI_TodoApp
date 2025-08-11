//
//  PreviewContainer.swift
//  TodoApp
//
//  Created by 박서인 on 8/11/25.
//

import Foundation
import SwiftData

@MainActor
class PreviewContainer {
    static let shared: PreviewContainer = PreviewContainer()
    
    let container: ModelContainer
    
    init() {
        let schema = Schema([
            TodoItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema,
                                                    isStoredInMemoryOnly: true,
                                                    cloudKitDatabase: .none)
        
        do {
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            insertPreviewData()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    func insertPreviewData() {
        let today = Date()
        let calendar = Calendar.current
        
        let todos: [(String, Date?, Priority, Date)] = [
            ("Buy groceries",
             today,
             .medium,
             calendar.date(byAdding: .day, value: -1, to: today) ?? today // createdAt
            ),
            ("강아지 산책",
             nil,
             .low,
             calendar.date(byAdding: .day, value: -2, to: today) ?? today
            ),
            ("Study SwiftData",
             calendar.date(byAdding: .hour, value: 5, to: today) ?? today,
             .high,
             calendar.date(byAdding: .day, value: -1, to: today) ?? today
            ),
            ("저녁 장보기",
             nil,
             .medium,
             calendar.date(byAdding: .day, value: -3, to: today) ?? today
            ),
            ("헬스장 가기",
             calendar.date(byAdding: .day, value: 3, to: today) ?? today,
             .low,
             calendar.date(byAdding: .day, value: -5, to: today) ?? today
            ),
            ("Call mom",
             nil,
             .medium,
             calendar.date(byAdding: .day, value: -4, to: today) ?? today
            ),
            ("세금 납부 확인",
             calendar.date(byAdding: .day, value: 14, to: today) ?? today,
             .high,
             calendar.date(byAdding: .day, value: -10, to: today) ?? today
            ),
            ("Refactor ViewModel",
             nil,
             .medium,
             calendar.date(byAdding: .day, value: -6, to: today) ?? today
            )
        ]
        
        for (title, dueDate, priority, createdAt) in todos {
            let todo = TodoItem(title: title, priority: priority, dueDate: dueDate, createdAt: createdAt)
            container.mainContext.insert(todo)
        }
        
        // 첫번째 Todo를 완료 상태로 변경
        if let firstTodo = try? container.mainContext.fetch(FetchDescriptor<TodoItem>()).first {
            firstTodo.isCompleted = true
        }
        
        // 변경사항을 저장
        try? container.mainContext.save()
    }
}
