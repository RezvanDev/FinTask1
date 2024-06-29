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
    private let geocoder = CLGeocoder()
    
    // Get user
    func getUser() -> User? {
        return realm.objects(User.self).first
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
                totalExpense += category.incomes.reduce(0.0) { $0 + $1.amount }
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
    func fetchSortedGroupedIncomes() -> [Date: [(category: CategoryIncome, items: [Income])]] {
        guard let user = getUser() else { return [:] }
        
        var groupedIncomes: [Date: [(category: CategoryIncome, items: [Income])]] = [:]
        
        for wallet in user.wallets {
            for category in wallet.categoriesIncome {
                let incomes = category.incomes
                for income in incomes {
                    let date = Calendar.current.startOfDay(for: income.date)
                    if var incomesForDate = groupedIncomes[date] {
                        incomesForDate.append((category: category, items: [income]))
                        groupedIncomes[date] = incomesForDate
                    } else {
                        groupedIncomes[date] = [(category: category, items: [income])]
                    }
                }
            }
        }
        
        return groupedIncomes
    }
    
    // Get sorted expenses
    func fetchSortedGroupedExpenses() -> [Date: [(category: CategoryExpense, items: [Expense])]] {
        guard let user = getUser() else { return [:] }
        
        var groupedExpenses: [Date: [(category: CategoryExpense, items: [Expense])]] = [:]
        
        for wallet in user.wallets {
            for category in wallet.categoriesExpense {
                let expenses = category.incomes
                for expense in expenses {
                    let date = Calendar.current.startOfDay(for: expense.date)
                    if var expensesForDate = groupedExpenses[date] {
                        expensesForDate.append((category: category, items: [expense]))
                        groupedExpenses[date] = expensesForDate
                    } else {
                        groupedExpenses[date] = [(category: category, items: [expense])]
                    }
                }
            }
        }
        return groupedExpenses
    }
    
    // Create user first time. When user login in app
    func createInitialUserIfNeeded(locationManager: CLLocationManager) {
        let userExists = realm.objects(User.self).first != nil
        guard !userExists else { return }
        
        let user = User()
        user.hasSubscription = false
        
        let wallet = Wallet()
        wallet.name = "Default Wallet"
        
        determineCurrencyForCurrentLocation(locationManager: locationManager) { currency in
            if let currency = currency {
                wallet.nameCurrency = currency
            } else {
                wallet.nameCurrency = "USD" // default USD
            }
            wallet.currentFunds = 0.0
            
            try! self.realm.write {
                self.realm.add(user)
                user.wallets.append(wallet)
            }
        }
    }
    
    // find geo user
    private func determineCurrencyForCurrentLocation(locationManager: CLLocationManager, completion: @escaping (String?) -> Void) {
        guard let location = locationManager.location else {
            completion(nil)
            return
        }
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first else {
                completion(nil)
                return
            }
            
            let countryCode = placemark.isoCountryCode
            var currency: String?
            
            switch countryCode {
            case "KZ":
                currency = "KZT"
            case "RU":
                currency = "RUB"
            default:
                currency = nil
            }
            
            completion(currency)
        }
    }
}
