//
//  CategoryViewController.swift
//  FinTask
//
//  Created by Иван Незговоров on 05.07.2024.
//

import UIKit

class CategoryViewController: UIViewController {

    private var categoriesIncome: [CategoryIncome]?
    private var categoriesExpense: [CategoryExpense]?
    
    var isIncome: Bool?

    private lazy var categoryTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        return lbl
    }()
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseId)
        tb.backgroundColor = .clear
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    private lazy var addButton: UIButton = {
        let button = UIButton(frame: CGRect(x: ((view.bounds.width - 150) / 2) - 25, y: view.bounds.height - 130, width: 200, height: 40))
        button.layer.cornerRadius = 10
        button.backgroundColor = AppColors.mainGreen
        button.addTarget(self, action: #selector(addButtonTap), for: .touchUpInside)
        button.setTitle("НОВАЯ КАТЕГОРИЯ", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setup()
    }

}

// MARK: -- Setup Layer()
private extension CategoryViewController {
    func setup() {
        view.backgroundColor = AppColors.lightGrayMain
        if isIncome! {
            setupIncome()
        } else {
            setupExpense()
            
        }
        
        setupTitle()
        setupTableView()
        view.addSubview(addButton)
    }
    
    func setupTitle() {
        view.addSubview(categoryTitle)
        
        NSLayoutConstraint.activate([
            categoryTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            categoryTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: categoryTitle.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
            
        ])
    }
}

// MARK: -- Setup Income
private extension CategoryViewController {
    func setupIncome() {
        categoryTitle.text = "Категории доходов"
    }
}

// MARK: -- Setup Expense
private extension CategoryViewController {
    func setupExpense() {
        categoryTitle.text = "Категории Расходов"
    }
}

// MARK: -- Fetch data
private extension CategoryViewController {
    func fetchData() {
        categoriesIncome = StorageManager.shared.getAllIncomeCategories()
        categoriesExpense = StorageManager.shared.getAllExpenseCategories()
    }
}

// MARK: -- OBJC
private extension CategoryViewController {
    @objc func addButtonTap() {
        let vc = AddCategoryViewController()
        vc.isIncome = isIncome!
        vc.closure = { [weak self] result in
            if result {
                self?.fetchData()
                self?.tableView.reloadData()
            }
        }
        present(vc, animated: true)
    }
}

// MARK: -- UITableViewDelegate, UITableViewDataSource
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        isIncome! ? categoriesIncome?.count ?? 0 : categoriesExpense?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseId, for: indexPath) as! CategoryTableViewCell
       
        let provaider = isIncome! ? categoriesIncome![indexPath.section]: categoriesExpense![indexPath.section]
        if let category = provaider as? CategoryIncome {
            cell.config(item: category)
        } else if let category = provaider as? CategoryExpense {
            cell.config(item: category)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
