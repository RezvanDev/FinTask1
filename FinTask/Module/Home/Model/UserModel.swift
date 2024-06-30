//
//  UserModel.swift
//  FinTask
//
//  Created by Иван Незговоров on 26.06.2024.
//

import RealmSwift
import Foundation

class User: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var hasSubscription: Bool = false
    let wallets = List<Wallet>()
    let savings = List<Saving>()
    @objc dynamic var monthlyPayment: MonthlyPayment?
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Wallet: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var nameCurrency: String = ""
    @objc dynamic var currentFunds: Double = 0.0
    let categoriesIncome = List<CategoryIncome>()
    let categoriesExpense = List<CategoryExpense>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class CategoryIncome: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    let incomes = List<Income>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class CategoryExpense: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    let incomes = List<Expense>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
 
class Income: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var date: Date = Date()
    @objc dynamic var image: String = ""
    @objc dynamic var note: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Expense: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var date: Date = Date()
    @objc dynamic var image: String = ""
    @objc dynamic var note: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Saving: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var amount: Double = 0.0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class MonthlyPayment: Object {
    @objc dynamic var id: String = UUID().uuidString
    let procedures = List<Procedure>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Procedure: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var amount: Double = 0.0
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

