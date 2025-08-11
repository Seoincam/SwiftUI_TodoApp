//
//  TodoRowView.swift
//  TodoApp
//
//  Created by 박서인 on 8/9/25.
//

import SwiftUI

struct TodoRowView: View {
    let item: TodoItem
    
    var body: some View {
        NavigationLink {
            TodoDetailView(item: item)
        } label: {
            Text("\(item.title) at \(item.createdAt, format: Date.FormatStyle(date: .numeric, time: .standard))")
        }
        .swipeActions(edge: .leading) {
            Button("Edit") {
                print("수정!")
            }
            .tint(.yellow)
        }
    }
}

#Preview {
    TodoRowView(item: TodoItem(title: "Test todo"))
}
