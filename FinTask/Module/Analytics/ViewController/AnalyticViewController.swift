//
//  AnalyticViewController.swift
//  FinTask
//
//  Created by Иван Незговоров on 24.06.2024.
//

import UIKit
import DGCharts

class AnalyticViewController: UIViewController {
    
    private var expenseCategories: [CategoryExpense]?
    private var incomeCategories: [CategoryIncome]?
    private var isShowingExpenses: Bool = true
    private var selectedTimeInterval: TimeInterval = .day
    
    private lazy var analyticsTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Аналитика"
        lbl.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        return lbl
    }()
    private lazy var pieChartView: PieChartView = {
        let chartView = PieChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.legend.enabled = true
        chartView.drawEntryLabelsEnabled = false
        chartView.drawHoleEnabled = true
        chartView.holeColor = UIColor.white
        chartView.transparentCircleColor = UIColor.white.withAlphaComponent(0.5)
        chartView.isUserInteractionEnabled = false
        return chartView
    }()
    private lazy var filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выбрать интервал", for: .normal)
        button.addTarget(self, action: #selector(showTimeIntervalOptions), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Expenses", "Incomes"])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchCategories()
        updateChartData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCategories()
        updateChartData()
    }
}

// MARK: -- Setup Layer
private extension AnalyticViewController {
    func setup() {
        view.backgroundColor = .white
        setupAnalyticsTitle()
        setupFilterButton()
        setupPieChartView()
        setupSegmentedControl()
    }
    
    // Setup history title
    func setupAnalyticsTitle() {
        view.addSubview(analyticsTitle)
        
        NSLayoutConstraint.activate([
            analyticsTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            analyticsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    // Setup charts
    func setupPieChartView() {
        view.addSubview(pieChartView)
        
        NSLayoutConstraint.activate([
            pieChartView.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: 20),
            pieChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pieChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pieChartView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    // Setup SC
    func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: pieChartView.bottomAnchor, constant: 20),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    // Setup filter button
    func setupFilterButton() {
        view.addSubview(filterButton)
        
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: analyticsTitle.bottomAnchor, constant: 10),
            filterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
}
// MARK: -- Data Fetching
private extension AnalyticViewController {
    func fetchCategories() {
        expenseCategories = StorageManager.shared.getAllExpenseCategories()
        incomeCategories = StorageManager.shared.getAllIncomeCategories()
    }
    
    func updateChartData() {
        var entries: [PieChartDataEntry] = []
        let now = Date()
        let calendar = Calendar.current
        var totalAmount: Double = 0
        
        if isShowingExpenses {
            entries = expenseCategories!.compactMap { category in
                let filteredExpenses = category.expenses.filter { expense in
                    switch self.selectedTimeInterval {
                    case .day:
                        return calendar.isDateInToday(expense.date)
                    case .week:
                        return calendar.isDate(expense.date, equalTo: now, toGranularity: .weekOfYear)
                    case .month:
                        return calendar.isDate(expense.date, equalTo: now, toGranularity: .month)
                    default:
                        return false
                    }
                }
                let categoryTotal = filteredExpenses.reduce(0) { $0 + $1.amount }
                totalAmount += categoryTotal
                return PieChartDataEntry(value: categoryTotal, label: category.name)
            }
        } else {
            entries = incomeCategories!.compactMap { category in
                let filteredIncomes = category.incomes.filter { income in
                    switch self.selectedTimeInterval {
                    case .day:
                        return calendar.isDateInToday(income.date)
                    case .week:
                        return calendar.isDate(income.date, equalTo: now, toGranularity: .weekOfYear)
                    case .month:
                        return calendar.isDate(income.date, equalTo: now, toGranularity: .month)
                    default:
                        return false
                    }
                }
                let categoryTotal = filteredIncomes.reduce(0) { $0 + $1.amount }
                totalAmount += categoryTotal
                return PieChartDataEntry(value: categoryTotal, label: category.name)
            }
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        dataSet.drawValuesEnabled = false
        dataSet.colors = ChartColorTemplates.pastel()
        
        let data = PieChartData(dataSet: dataSet)
        pieChartView.data = data
        pieChartView.notifyDataSetChanged()
        
        
        let totalText = isShowingExpenses ? "Total Expenses\n\(totalAmount)" : "Total Incomes\n\(totalAmount)"
        pieChartView.centerText = totalText
    }
}

// MARK: -- Objc
private extension AnalyticViewController {
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        isShowingExpenses = sender.selectedSegmentIndex == 0
        updateChartData()
    }
    
    @objc private func showTimeIntervalOptions() {
        let alertController = UIAlertController(title: "Выбрать интервал", message: nil, preferredStyle: .actionSheet)
        
        let oneDayAction = UIAlertAction(title: "1 день", style: .default) { _ in
            self.selectedTimeInterval = .day
            self.updateChartData()
        }
        
        let sevenDaysAction = UIAlertAction(title: "7 дней", style: .default) { _ in
            self.selectedTimeInterval = .week
            self.updateChartData()
        }
        
        let thirtyDaysAction = UIAlertAction(title: "30 дней", style: .default) { _ in
            self.selectedTimeInterval = .month
            self.updateChartData()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertController.addAction(oneDayAction)
        alertController.addAction(sevenDaysAction)
        alertController.addAction(thirtyDaysAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
