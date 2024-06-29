//
//  NewOperationViewController.swift
//  FinTask
//
//  Created by Иван Незговоров on 27.06.2024.
//

import UIKit

class NewOperationViewController: UIViewController {
    
    var isExpense: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension NewOperationViewController {
    func setup() {
        view.backgroundColor = .white
        if isExpense == true {
            
        } else {
                
        }
    }
    
    
}
