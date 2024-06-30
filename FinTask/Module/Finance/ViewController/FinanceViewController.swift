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
    
    private lazy var buttonMenu: UIButton = {
        let button = UIButton(frame: CGRect(x: view.bounds.width - 50 - 20, y: view.bounds.height - 50 - 88, width: 50, height: 50))
        button.addTarget(self, action: #selector(buttonMenuTap), for: .touchUpInside)
        button.backgroundColor = .green
        button.layer.cornerRadius = 25
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private lazy var buttonIncome: UIButton = {
        let button = UIButton(frame: CGRect(x: view.bounds.width - 50 - 20, y: view.bounds.height - 50 - 88, width: 50, height: 50))
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.backgroundColor = AppColors.mainGreen
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonGoToNewOperation), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.alpha = 0
        return button
    }()
    
    private lazy var buttonExpense: UIButton = {
        let button = UIButton(frame: CGRect(x: view.bounds.width - 50 - 20, y: view.bounds.height - 50 - 88, width: 50, height: 50))
        button.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(buttonGoToNewOperation), for: .touchUpInside)
        button.alpha = 0
        return button
    }()
    
    private var sections: [(date: Date, items: [Any])] = []
    private var buttonsAreVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
        setupButtons()
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
        
        var allItems: [(date: Date, items: [(category: Any, items: [Any], currency: String)])] = []
        
        // Combine and group by date and category
        let allDates = Set(groupedIncomes.keys).union(Set(groupedExpenses.keys))
        
        for date in allDates {
            var dateItems: [(category: Any, items: [Any], currency: String)] = []
            
            if let incomesForDate = groupedIncomes[date] {
                for income in incomesForDate {
                    dateItems.append((category: income.category, items: income.items, currency: income.currency))
                }
            }
            
            if let expensesForDate = groupedExpenses[date] {
                for expense in expensesForDate {
                    dateItems.append((category: expense.category, items: expense.items, currency: expense.currency))
                }
            }
            
            allItems.append((date: date, items: dateItems))
        }
        
        sections = allItems.sorted(by: { $0.date > $1.date })
        tableView.reloadData()
    }

    
    // Format date
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    // Setup buttons
    func setupButtons() {
        view.addSubview(buttonExpense)
        view.addSubview(buttonIncome)
        view.addSubview(buttonMenu)
    }
}

// MARK: -- Obj methods
private extension FinanceViewController {
    @objc func buttonMenuTap() {
        buttonsAreVisible.toggle()
        
        UIView.animate(withDuration: 0.3) {
            if self.buttonsAreVisible {
                self.buttonIncome.alpha = 1
                self.buttonExpense.alpha = 1
                self.buttonIncome.frame = CGRect(x: self.view.bounds.width - 50 - 20, y: self.view.bounds.height - 50 - 88 - 75, width: 50, height: 50)
                self.buttonExpense.frame = CGRect(x: self.view.bounds.width - 50 - 20, y: self.view.bounds.height - 50 - 88 - 150, width: 50, height: 50)
            } else {
                self.buttonIncome.alpha = 0
                self.buttonExpense.alpha = 0
                self.buttonIncome.frame = CGRect(x: self.view.bounds.width - 50 - 20, y: self.view.bounds.height - 50 - 88, width: 50, height: 50)
                self.buttonExpense.frame = CGRect(x: self.view.bounds.width - 50 - 20, y: self.view.bounds.height - 50 - 88, width: 50, height: 50)
            }
        }
    }
    
    @objc func buttonGoToNewOperation(sender: UIButton) {
        var vc = UIViewController()
        if sender == buttonExpense {
            let addExpenseVC = AddExpenseViewController()
            addExpenseVC.reloadDataFinanceViewController = {[weak self] res in
                if res {
                    self?.fetchData()
                    self?.tableView.reloadData()
                }
            }
            vc = addExpenseVC
        } else {
            
        }
        present(vc, animated: true)
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
           
           if let incomeItem = item as? (category: CategoryIncome, items: [Income], currency: String), let income = incomeItem.items.first {
               cell.configure(with: incomeItem.category, data: income, currency: incomeItem.currency)
           } else if let expenseItem = item as? (category: CategoryExpense, items: [Expense], currency: String), let expense = expenseItem.items.first {
               cell.configure(with: expenseItem.category, data: expense, currency: expenseItem.currency)
           }
           
           cell.selectionStyle = .none
           
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}


