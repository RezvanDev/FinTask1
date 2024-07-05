//
//  Helpers.swift
//  FinTask
//
//  Created by Иван Незговоров on 03.07.2024.
//

import Foundation
import UIKit

class Helpers {
    static let shared = Helpers()
    private init (){}
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }    
    
    
    func sentToMail(to: String) {
        let mailString = "mailto:\(to)"

        guard let mailUrl = URL(string: mailString) else {
            return
        }
        if UIApplication.shared.canOpenURL(mailUrl) {
            UIApplication.shared.open(mailUrl)
        }
    }
}


