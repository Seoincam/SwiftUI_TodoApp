//
//  TodoListView.swift
//  TodoApp
//
//  Created by 박서인 on 8/9/25.
//

import SwiftUI
import SwiftData

struct TodoListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var todos: [TodoItem]
    
    let searchText: String
    let priorityFilter: Priority?
    
    init(searchText: String = "", priorityFilter: Priority? = nil) {
        self.searchText = searchText
        self.priorityFilter = priorityFilter
        
        let predicate = #Predicate<TodoItem> { todo in
            searchText.isEmpty ? true : todo.title.contains(searchText)
        }
        _todos = Query(filter: predicate, sort: [SortDescriptor(\TodoItem.createdAt)])
    }
    
    var filteredTodos: [TodoItem] {
        if let priority = priorityFilter {
            return todos.filter { $0.priority == priority }
        }
        return todos
    }
    
    var body: some View {
        List {
            ForEach(filteredTodos) { item in
                TodoRowView(todo: item)
            }
            .onDelete(perform: deleteItems)
        }
        
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(todos[index])
            }
        }
    }
}
#Preview {
    TodoListView()
        .modelContainer(PreviewContainer.shared.container)
}
