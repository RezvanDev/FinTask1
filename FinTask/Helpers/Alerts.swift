//
//  Alerts.swift
//  FinTask
//
//  Created by Иван Незговоров on 30.06.2024.
//

import UIKit

class Alerts {
    static let shared = Alerts()
    
    func alertSetExpense(title: String, decription: String, presenter: UIViewController) {
        let alert = UIAlertController(title: title, message: decription, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Закрыть", style: .cancel)
        alert.addAction(cancel)
        presenter.present(alert, animated: true)
    }
}
