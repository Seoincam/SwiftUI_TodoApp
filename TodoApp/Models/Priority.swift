//
//  Priority.swift
//  TodoApp
//
//  Created by 박서인 on 8/11/25.
//

import Foundation

enum Priority: Int, Codable, CaseIterable {
    case low = 0
    case medium = 1
    case high = 2
    
    var title: String {
        switch self {
        case .low:
            return "낮음"
        case .medium:
            return "중간"
        case .high:
            return "높음"
        }
    }
}
