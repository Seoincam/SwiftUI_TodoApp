//
//  AddTodoView.swift
//  TodoApp
//
//  Created by 박서인 on 8/9/25.
//

import SwiftUI

struct AddTodoView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var priority: Priority = .medium
    @State private var dueDateEnabled: Bool = false
    @State private var dueDate: Date?
    
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
            .navigationTitle("New Todo")
            .animation(.default, value: dueDateEnabled)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let todo = TodoItem(title: title, priority: priority, dueDate: dueDateEnabled ? dueDate ?? Date() : nil)
                        modelContext.insert(todo)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddTodoView()
}
