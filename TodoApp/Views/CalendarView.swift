//
//  CalendarView.swift
//  TodoApp
//
//  Created by 박서인 on 8/11/25.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    @Query private var todos: [TodoItem]
    
    @State private var selectedDate: Date = Date()
    
    private var todosForSelectedData: [TodoItem] {
        todos.filter { todo in
            todo.dueDate != nil
            ? Calendar.current.isDate(todo.dueDate!, inSameDayAs: selectedDate)
            : false
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker("날짜를 고르세요", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .padding()
                
                List {
                    ForEach(todosForSelectedData) { todo in
                        TodoRowView(todo: todo)
                    }
                }
            }
            .animation(.default, value: selectedDate)
            .navigationTitle("캘린더")
        }
    }
}

#Preview {
    CalendarView()
        .modelContainer(PreviewContainer.shared.container)
}
