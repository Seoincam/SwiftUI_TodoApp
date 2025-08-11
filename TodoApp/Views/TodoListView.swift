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
    
    let searchText: String
    
    @Query private var todos: [TodoItem]
    
    init(searchText: String = "") {
        self.searchText = searchText
        
        let predicate = #Predicate<TodoItem> { todo in
            searchText.isEmpty ? true : todo.title.contains(searchText)
        }
        _todos = Query(filter: predicate, sort: [SortDescriptor(\TodoItem.createdAt)])
    }
    
    var body: some View {
        List {
            ForEach(todos) { item in
                TodoRowView(item: item)
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
