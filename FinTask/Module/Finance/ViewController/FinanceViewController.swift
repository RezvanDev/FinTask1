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
    
    private lazy var historyTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "История"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lbl.textColor = .black
        return lbl
    }()
    
    private var sections: [(date: Date, items: [Any])] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
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
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // Setup Navigation Bar
    func setupNavBar() {
        let barButtonItem = UIBarButtonItem(customView: historyTitle)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    // fetch Data()
    private func fetchData() {
        let groupedIncomes = StorageManager.shared.fetchSortedGroupedIncomes()
        let groupedExpenses = StorageManager.shared.fetchSortedGroupedExpenses()
        
        var allItems: [(date: Date, items: [(category: Category, items: [Any])])] = []
        
        // Combine and group by date and category
        let allDates = Set(groupedIncomes.keys).union(Set(groupedExpenses.keys))
        
        for date in allDates {
            var dateItems: [(category: Category, items: [Any])] = []
            
            if let incomesForDate = groupedIncomes[date] {
                for (category, incomes) in incomesForDate {
                    dateItems.append((category: category, items: incomes))
                }
            }
            
            if let expensesForDate = groupedExpenses[date] {
                for (category, expenses) in expensesForDate {
                    dateItems.append((category: category, items: expenses))
                }
            }
            
            // Sort items within each category by date descending
            dateItems.sort { $0.category.name < $1.category.name }
            
            allItems.append((date: date, items: dateItems))
        }
        
        // Sort by date descending
        allItems.sort { $0.date > $1.date }
        
        sections = allItems
        tableView.reloadData()
    }
    
    
    // Format date
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}

// MARK: -- UITableViewDelegate, UITableViewDataSource
extension FinanceViewController:  UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FinanceTableViewCell.reuseId, for: indexPath) as! FinanceTableViewCell
        
        let item = sections[indexPath.section].items[indexPath.row]
        
        if let (category, incomes) = item as? (category: Category, items: [Income]) {
            // Configure cell with income data
            if let income = incomes.first {
                cell.configure(with: category, data: income)
            }
        } else if let (category, expenses) = item as? (category: Category, items: [Expense]) {
            // Configure cell with expense data
            if let expense = expenses.first {
                cell.configure(with: category, data: expense)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = sections[section].date
        
        if Calendar.current.isDateInToday(date) {
            return "Сегодня"
        } else if Calendar.current.isDateInYesterday(date) {
            return "Вчера"
        } else {
            return formatDate(date)
        }
    }
    

}


