//
//  Helpers.swift
//  FinTask
//
//  Created by Иван Незговоров on 03.07.2024.
//

import Foundation

class Helpers {
    static let shared = Helpers()
    private init (){}
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }    
}
