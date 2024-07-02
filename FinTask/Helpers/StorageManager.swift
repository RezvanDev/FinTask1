//
//  StorageManager.swift
//  FinTask
//
//  Created by Иван Незговоров on 26.06.2024.
//

import Foundation
import RealmSwift
import CoreLocation

class StorageManager {
    static let shared = StorageManager()
    private var realm = try! Realm()
    
}

// MARK: -- Update methods
extension StorageManager {
    func updateCategoryLimit(categoryId: String, newLimit: Double) {
        guard let user = getUser() else { return }
        
        for wallet in user.wallets {
            if let category = wallet.categoriesExpense.first(where: { $0.id == categoryId }) {
                try! realm.write {
                    category.limits = newLimit
                }
                break
            }
        }
    }
}

// MARK: -- Set methods
extension StorageManager {
    // Method to create a new expense for a given category ID
    func createExpense(for categoryId: String, amount: Double, date: Date, note: String?) {
        guard let user = getUser() else { return }
        
        for wallet in user.wallets {
            if let category = wallet.categoriesExpense.first(where: { $0.id == categoryId }) {
                let expense = Expense()
                expense.amount = amount
                expense.date = date
                expense.note = note
                
                try! realm.write {
                    category.expenses.append(expense)
                }
                break
            }
        }
    }
    
    func createIncome(for categoryId: String, amount: Double, date: Date, note: String?) {
        guard let user = getUser() else { return }
        
        for wallet in user.wallets {
            if let category = wallet.categoriesIncome.first(where: { $0.id == categoryId }) {
                let income = Income()
                income.amount = amount
                income.date = date
                income.note = note
                
                try! realm.write {
                    category.incomes.append(income)
                }
                break
            }
        }
    }
}

// MARK: -- Get methods
extension StorageManager {
    // Get user
    func getUser() -> User? {
        return realm.objects(User.self).first
    }
    // Get all expense categories
    func getAllExpenseCategories() -> [CategoryExpense] {
        guard let user = getUser() else { return [] }
        var allExpenseCategories: [CategoryExpense] = []
        
        for wallet in user.wallets {
            allExpenseCategories += wallet.categoriesExpense
        }
        
        return allExpenseCategories
    }
    
    func getAllIncomeCategories() -> [CategoryIncome] {
        guard let user = getUser() else { return [] }
        var allIncomesCategories: [CategoryIncome] = []
        
        for wallet in user.wallets {
            allIncomesCategories += wallet.categoriesIncome
        }
        
        return allIncomesCategories
    }
    
    // Method to calculate total income
    func totalIncome() -> Double {
        guard let user = getUser() else { return 0.0 }
        
        var totalIncome: Double = 0.0
        
        for wallet in user.wallets {
            for category in wallet.categoriesIncome {
                totalIncome += category.incomes.reduce(0.0) { $0 + $1.amount }
            }
        }
        return totalIncome
    }
    
    // Method to calculate total expense
    func totalExpense() -> Double {
        guard let user = getUser() else { return 0.0 }
        
        var totalExpense: Double = 0.0
        
        for wallet in user.wallets {
            for category in wallet.categoriesExpense {
                totalExpense += category.expenses.reduce(0.0) { $0 + $1.amount }
            }
        }
        return totalExpense
    }
    
    // Method to calculate total savings
    func totalSavings() -> Double {
        guard let user = getUser() else { return 0.0 }
        return user.savings.reduce(0.0) { $0 + $1.amount }
    }
    
    // Get sorted incomes
    func fetchSortedGroupedIncomes() -> [Date: [(category: CategoryIncome, items: [Income], currency: String)]] {
        guard let user = getUser() else { return [:] }
        
        var groupedIncomes: [Date: [(category: CategoryIncome, items: [Income], currency: String)]] = [:]
        
        for wallet in user.wallets {
            let currency = wallet.nameCurrency
            for category in wallet.categoriesIncome {
                let incomes = category.incomes
                for income in incomes {
                    let date = Calendar.current.startOfDay(for: income.date)
                    if var incomesForDate = groupedIncomes[date] {
                        incomesForDate.append((category: category, items: [income], currency: currency))
                        groupedIncomes[date] = incomesForDate
                    } else {
                        groupedIncomes[date] = [(category: category, items: [income], currency: currency)]
                    }
                }
            }
        }
        
        return groupedIncomes
    }
    
    // Get sorted expenses
    func fetchSortedGroupedExpenses() -> [Date: [(category: CategoryExpense, items: [Expense], currency: String)]] {
        guard let user = getUser() else { return [:] }
        
        var groupedExpenses: [Date: [(category: CategoryExpense, items: [Expense], currency: String)]] = [:]
        
        for wallet in user.wallets {
            let currency = wallet.nameCurrency
            for category in wallet.categoriesExpense {
                let expenses = category.expenses
                for expense in expenses {
                    let date = Calendar.current.startOfDay(for: expense.date)
                    if var expensesForDate = groupedExpenses[date] {
                        expensesForDate.append((category: category, items: [expense], currency: currency))
                        groupedExpenses[date] = expensesForDate
                    } else {
                        groupedExpenses[date] = [(category: category, items: [expense], currency: currency)]
                    }
                }
            }
        }
        
        return groupedExpenses
    }
}


// MARK: -- Launch first time
extension StorageManager {
    // Create user first time. When user login in app
    func createInitialUserIfNeeded(locationManager: CLLocationManager, currency: String?) {
        let userExists = realm.objects(User.self).first != nil
        guard !userExists else { return }
        
        let user = User()
        user.hasSubscription = false
        
        let wallet = Wallet()
        wallet.name = "Default Wallet"
        wallet.nameCurrency = currency ?? "USD"
        wallet.currentFunds = 0.0
        
        // Add default categories for incomes
        let categoriesIncome = ["Работа": "doc", "Фриланс": "network", "Подарок": "gift", "Банк": "creditcard"]
        for (categoryName, categoryImage) in categoriesIncome {
            let category = CategoryIncome()
            category.name = categoryName
            category.image = categoryImage
            try! realm.write {
                wallet.categoriesIncome.append(category)
            }
        }
        
        // Add default categories for expenses
        let categoriesExpense = ["Развлечения": "cart", "Транспорт": "car", "Бизнес": "banknote.fill", "Продукты": "carrot", "Переводы": "dollarsign.arrow.circlepath", "Подарки": "gift", "Еда": "fork.knife"]
        for  (categoryName, categoryImage) in categoriesExpense {
            let category = CategoryExpense()
            category.name = categoryName
            category.image = categoryImage
            try! realm.write {
                wallet.categoriesExpense.append(category)
            }
        }
        
        try! realm.write {
            realm.add(user)
            user.wallets.append(wallet)
        }
    }
}
