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
    
    init(todo: TodoItem) {
        self.todo = todo
        self._title = State(initialValue: todo.title)
    }
     
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                }
            }
            .navigationTitle("Edit Todo")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        todo.title = title
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
