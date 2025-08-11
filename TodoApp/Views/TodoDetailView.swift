//
//  TodoDetailView.swift
//  TodoApp
//
//  Created by 박서인 on 8/9/25.
//

import SwiftUI

struct TodoDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var item: TodoItem
    
    @State private var showingEditView: Bool = false
    
    var body: some View {
        NavigationStack {
            Text("\(item.title) at \(item.createdAt, format: Date.FormatStyle(date: .numeric, time: .standard))")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Delete") {
                            modelContext.delete(item)
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Edit") {
                            // 수정 가능
                            showingEditView = true
                        }
                    }
                }
                .navigationTitle(item.title)
                .sheet(isPresented: $showingEditView) {
                    EditTodoView(todo: item)
        }

        }
    }
}

#Preview {
    TodoDetailView(item: TodoItem(title: "Test Todo"))
}
