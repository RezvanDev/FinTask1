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
    
    func alertSetSavingError(title: String, decription: String, presenter: UIViewController) {
        let alert = UIAlertController(title: title, message: decription, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Закрыть", style: .cancel)
        alert.addAction(cancel)
        presenter.present(alert, animated: true)
    }
    
    func alertSetSaving(saving: Saving, presenter: UIViewController, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: "Добавление суммы", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Введите сумму"
            textField.keyboardType = .decimalPad
            textField.text = "0.0"
        }
        
        let done = UIAlertAction(title: "Добавить", style: .default) { _ in
            if let textField = alert.textFields?.first, let text = textField.text {
                if text != "" {
                    if let double = Double(text) {
                        StorageManager.shared.updateSaving(savingId: saving.id, sum: double)
                        completion()
                    }
                } else {
                    self.alertForSetSaving(presenter: presenter)
                }
                
            }
        }
        
        let cancel = UIAlertAction(title: "Закрыть", style: .cancel)
        alert.addAction(done)
        alert.addAction(cancel)
        presenter.present(alert, animated: true)
    }
    
    func alertForSetSaving(presenter: UIViewController) {
        let alert = UIAlertController(title: "Ошибка", message: "Заполните поле введите сумму", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Закрыть", style: .cancel)
        alert.addAction(cancel)
        presenter.present(alert, animated: true)
    }
    
    func alertSetMonthlyPaymentError(title: String, decription: String, presenter: UIViewController) {
        let alert = UIAlertController(title: title, message: decription, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Закрыть", style: .cancel)
        alert.addAction(cancel)
        presenter.present(alert, animated: true)
    }
    
}


