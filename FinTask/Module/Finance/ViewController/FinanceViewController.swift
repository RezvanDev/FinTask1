//
//  FinanceViewController.swift
//  FinTask
//
//  Created by Иван Незговоров on 24.06.2024.
//

import UIKit

class FinanceViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FinanceTableViewCell.self, forCellReuseIdentifier: FinanceTableViewCell.reuseId)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: -- SetupLayer
private extension FinanceViewController {
    func setup() {
        view.backgroundColor = .white
        setupCollection()
        setupNavBar()
    }
    
    // setup collection
    func setupCollection() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // Setup Navigation Bar
    func setupNavBar() {
        let historyTitle = UILabel()
        historyTitle.text = "История"
        historyTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        historyTitle.textColor = .black
        
        let stackView = UIStackView(arrangedSubviews: [historyTitle])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        
        let barButtonItem = UIBarButtonItem(customView: stackView)
        navigationItem.leftBarButtonItem = barButtonItem
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 20),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
            historyTitle.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5),

        ])
    }
}

// MARK: -- UITableViewDelegate, UITableViewDataSource
extension FinanceViewController:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FinanceTableViewCell.reuseId, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}


