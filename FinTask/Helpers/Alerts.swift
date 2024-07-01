//
//  Alerts.swift
//  FinTask
//
//  Created by Иван Незговоров on 30.06.2024.
//

import UIKit
import RealmSwift

class Alerts {
    static let shared = Alerts()
    
    func alertSetExpense(title: String, decription: String, presenter: UIViewController) {
        let alert = UIAlertController(title: title, message: decription, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Закрыть", style: .cancel)
        alert.addAction(cancel)
        presenter.present(alert, animated: true)
    }
    
    func alertSetLimits(category: CategoryExpense,presenter: UIViewController, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "Установка лимита", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Введите лимит"
            textField.keyboardType = .decimalPad
            textField.text = "\(category.limits)"
        }
        
        let done = UIAlertAction(title: "Добавить", style: .default) { _ in
            if let textField = alert.textFields?.first, let text = textField.text {
                if text == "" {
                    
                    StorageManager.shared.updateCategoryLimit(categoryId: category.id, newLimit: 0)
                    completion()
                } else {
                    if let double = Double(text) {
                        StorageManager.shared.updateCategoryLimit(categoryId: category.id, newLimit: double)
                        completion()
                    }
                }
                
            }
        }
        
        let cancel = UIAlertAction(title: "Закрыть", style: .cancel)
        alert.addAction(done)
        alert.addAction(cancel)
        presenter.present(alert, animated: true)
    }
}
