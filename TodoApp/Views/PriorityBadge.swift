//
//  PriorityBadge.swift
//  TodoApp
//
//  Created by 박서인 on 8/11/25.
//

import SwiftUI

struct PriorityBadge: View {
    let priority: Priority
    
    var body: some View {
        Text(priority.title)
            .font(.footnote)
            .padding(4)
            .background(backgroundColor)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 5))
    }
    
    private var backgroundColor: Color {
        switch priority {
        case .low: return .green
        case .medium: return .yellow
        case .high: return .red
        }
    }
}

#Preview {
    PriorityBadge(priority: .medium)
}
