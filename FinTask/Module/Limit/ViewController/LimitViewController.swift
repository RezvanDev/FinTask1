//
//  LimitViewController.swift
//  FinTask
//
//  Created by Иван Незговоров on 26.06.2024.
//

import UIKit

class LimitViewController: UIViewController {
    
    private var categories: [CategoryExpense]?
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Лимиты"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return lbl
    }()
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        
        tb.register(LimitTableViewCell.self, forCellReuseIdentifier: LimitTableViewCell.reuseId)
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
    }
}

// MARK: -- Setup layer
private extension LimitViewController {
    func setup() {
        view.backgroundColor = .white
        setupTitleLabel()
        setupTableView()
    }
    
    // Setup title
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    // Setup tableView
    func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: -- Fetch data
private extension LimitViewController {
    func fetchData() {
        categories = StorageManager.shared.getAllExpenseCategories()
    }
}

extension LimitViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LimitTableViewCell.reuseId, for: indexPath) as! LimitTableViewCell
        let provaider = categories![indexPath.section]
        cell.configure(category: provaider)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let provaider = categories![indexPath.section]
        Alerts.shared.alertSetLimits(category: provaider, presenter: self) {
            tableView.reloadData()
        }
    }
    
}
