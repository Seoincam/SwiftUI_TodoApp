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
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                    Picker("Priority", selection: $priority) {
                        ForEach(Priority.allCases, id: \.self) { priority in
                            Text(priority.title)
                                .tag(priority)
                        }
                    }
                }
            }
            .navigationTitle("New Todo")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let todo = TodoItem(title: title, priority: priority)
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
