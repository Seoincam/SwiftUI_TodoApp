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
    
    func formattedKoreanDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd (E)" // E = 요일 (월, 화, 수...)
        return formatter.string(from: date)
    }
    
    var body: some View {
            HStack {
                Image(systemName: todo.isCompleted ? "checkmark.square.fill" : "square")
                    .foregroundStyle(todo.isCompleted ? .green : .gray)
                
                VStack(alignment: .leading) {
                    Text(todo.title)
                        .strikethrough(todo.isCompleted)
                    
                    if let dueDate = todo.dueDate {
                        Text(formattedKoreanDate(dueDate))
                            .font(.caption)
                            .foregroundStyle(dueDate > Date.now ? .gray : .red)
                    }
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


