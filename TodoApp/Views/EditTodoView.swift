//
//  EditTodoView.swift
//  TodoApp
//
//  Created by 박서인 on 8/9/25.
//

import SwiftUI

struct EditTodoView: View {
    @Environment(\.dismiss) private var dismiss
    
    let todo: TodoItem
    
    @State private var title: String = ""
    @State private var priority: Priority = .medium
    @State private var dueDateEnabled: Bool = false
    @State private var dueDate: Date?
    
    init(todo: TodoItem) {
        self.todo = todo
        self._title = State(initialValue: todo.title)
        self._priority = State(initialValue: todo.priority)
        self._dueDateEnabled = State(initialValue: todo.dueDate != nil)
        self._dueDate = State(initialValue: todo.dueDate)
    }
     
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("제목", text: $title)
                    
                    Picker("우선순위", selection: $priority) {
                        ForEach(Priority.allCases, id: \.self) { priority in
                            Text(priority.title)
                                .tag(priority)
                        }
                    }
                    
                    Toggle("마감일", isOn: $dueDateEnabled)
                    
                    if (dueDateEnabled) {
                        DatePicker("마감일", selection: Binding(get: {
                            dueDate ?? Date()
                        }, set: {
                            dueDate = $0
                        }), displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                    }
                }
            }
            .navigationTitle("Edit Todo")
            .animation(.default, value: dueDateEnabled)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        todo.title = title
                        todo.priority = priority
                        todo.dueDate = dueDateEnabled ? dueDate : nil
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    EditTodoView(todo: TodoItem(title: "할 일 테스트"))
}
