//
//  EditSavingViewController.swift
//  FinTask
//
//  Created by Иван Незговоров on 03.07.2024.
//

import UIKit

class EditSavingViewController: UIViewController {
    
    var currentSaving: Saving?
    var closure: ((Bool) -> ())?
    private lazy var titleMain: UILabel = {
        let lbl = UILabel()
        lbl.text = "Test"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return lbl
    }()
    private lazy var buttonAppendSumm: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить сумму", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.tintColor = .black
        button.addTarget(self, action: #selector(buttonAppendSummTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: -- Set Layer
private extension EditSavingViewController {
    func setup() {
        view.backgroundColor = .white
        setupTitleMain()
        setupAppendSumButton()
    }
    
    // Setup title main
    func setupTitleMain() {
        view.addSubview(titleMain)
        guard let currentSaving else { return }
        titleMain.text = currentSaving.name
        
        NSLayoutConstraint.activate([
            titleMain.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleMain.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    // Setup button append summ
    func setupAppendSumButton() {
        view.addSubview(buttonAppendSumm)
        
        NSLayoutConstraint.activate([
            buttonAppendSumm.heightAnchor.constraint(equalToConstant: 40),
            buttonAppendSumm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonAppendSumm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonAppendSumm.topAnchor.constraint(equalTo: titleMain.bottomAnchor, constant: 20)
        ])
    }
}

// MARK: -- Objc
private extension EditSavingViewController {
    @objc func buttonAppendSummTap() {
        Alerts.shared.alertSetSaving(saving: currentSaving!, presenter: self) {
            self.closure?(true)
            self.dismiss(animated: true)
        }
    }
}
