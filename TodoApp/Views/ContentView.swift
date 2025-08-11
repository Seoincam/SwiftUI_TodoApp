//
//  ContentView.swift
//  TodoApp
//
//  Created by 박서인 on 8/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showingAddTodo = false
    @State private var searchText = ""
    @State private var priority: Priority?
    
    var body: some View {
        TabView {
            Tab("리스트", systemImage: "list.bullet") {
                NavigationStack {
                    VStack {
                        Picker("Priority", selection: $priority) {
                            ForEach([nil] + Priority.allCases, id: \.self) { p in
                                if let p = p {
                                    Text(p.title)
                                        .tag(Optional(p))
                                } else {
                                    Text("전체")
                                        .tag(nil as Priority?)
                                }
                            }
                        }
                        
                        
                        TodoListView(searchText: searchText, priorityFilter: priority)
                            .searchable(text: $searchText)
                            .navigationTitle("Todo List")
                            .animation(.default, value: priority)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    EditButton()
                                }
                                ToolbarItem {
                                    Button(action: {
                                        showingAddTodo = true
                                    }) {
                                        Label("Add Item", systemImage: "plus")
                                    }
                                }
                            }
                    }
                }
            }
            
            Tab("캘린더", systemImage: "calendar") {
                CalendarView()
            }
        }
        .sheet(isPresented: $showingAddTodo) {
            AddTodoView()
        }
    }
}

#Preview {
    ContentView()
    //        .modelContainer(for: TodoItem.self, inMemory: true)
        .modelContainer(PreviewContainer.shared.container)
}
