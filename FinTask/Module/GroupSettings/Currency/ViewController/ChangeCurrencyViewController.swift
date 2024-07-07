//
//  ChangeCurrencyViewController.swift
//  FinTask
//
//  Created by Иван Незговоров on 05.07.2024.
//

import UIKit

class ChangeCurrencyViewController: UIViewController {
    
    private let currencies = CurrencyModel().currencies
    var selectedCurrency: String?
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 45))
        button.setTitle(String(localized: "Cancel"), for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var saveButton: UIButton = {
        let button = UIButton(frame: CGRect(x: view.bounds.width - 110, y: 0, width: 100, height: 45))
        button.setTitle(String(localized: "Save"), for: .normal)
        button.setTitleColor(AppColors.mainGreen, for: .normal)
        button.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChangeCurrencyTableViewCell.self, forCellReuseIdentifier: ChangeCurrencyTableViewCell.reuseId)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: -- Setup layer
private extension ChangeCurrencyViewController {
    func setup() {
        view.backgroundColor = .white
        setupTableView()
        view.addSubview(cancelButton)
        view.addSubview(saveButton)
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: -- UITableViewDelegate and UITableViewDataSource
extension ChangeCurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChangeCurrencyTableViewCell.reuseId, for: indexPath) as! ChangeCurrencyTableViewCell
        let currency = currencies[indexPath.row]
        cell.configure(name: currency.name, code: currency.code)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCurrency = currencies[indexPath.row].code
    }
}


// MARK: -- OBJC
private extension ChangeCurrencyViewController {
    
    @objc func cancelButtonTap(){
        dismiss(animated: true)
    }
    
    @objc func saveButtonTap() {
        if selectedCurrency == nil {
            Alerts.shared.alertSetColorError(title: String(localized: "Error"), decription: String(localized: "Select_Currency"), presenter: self)
        } else {
            StorageManager.shared.updateCodeCurrencyInWallet(code: selectedCurrency!)
            dismiss(animated: true)
        }
    }
    
}
