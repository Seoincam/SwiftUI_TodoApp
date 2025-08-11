//
//  TodoRowView.swift
//  TodoApp
//
//  Created by 박서인 on 8/9/25.
//

import SwiftUI

struct TodoRowView: View {
    let todo: TodoItem
    
    @State private var showingEditView: Bool = false
    
    var body: some View {
            HStack {
                Image(systemName: todo.isCompleted ? "checkmark.square.fill" : "square")
                    .foregroundStyle(todo.isCompleted ? .green : .gray)
                
                VStack(alignment: .leading) {
                    Text(todo.title)
                        .strikethrough(todo.isCompleted)
                    Text(todo.createdAt, format: Date.FormatStyle(date: .numeric, time: .standard))
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                PriorityBadge(priority: todo.priority)
            }
            .onTapGesture {
                todo.isCompleted.toggle()
            }
            .onLongPressGesture(minimumDuration: 0.3) {
                showingEditView = true
            }
            .swipeActions(edge: .leading) {
                NavigationLink {
                    TodoDetailView(item: todo)
                } label: {
                    Text("detail")
                }
                .tint(.yellow)
            }
            .sheet(isPresented: $showingEditView) {
                NavigationStack {
                    EditTodoView(todo: todo)
                }
            }
        }
    }

#Preview {
    NavigationStack {
        List {
            TodoRowView(todo: TodoItem(title: "Test todo"))
        }
        .navigationTitle("Todo List")
    }
}


