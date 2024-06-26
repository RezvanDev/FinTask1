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
    private let realm = try! Realm()
    private let geocoder = CLGeocoder()
    
    // Get user
    func getUser() -> User? {
        return realm.objects(User.self).first
    }
    
    // Method to calculate total income
    func totalIncome() -> Double {
        guard let user = getUser() else { return 0.0 }
        return user.wallets.reduce(0.0) { $0 + $1.incomes.reduce(0.0) { $0 + $1.amount } }
    }
    
    // Method to calculate total expense
    func totalExpense() -> Double {
        guard let user = getUser() else { return 0.0 }
        return user.wallets.reduce(0.0) { $0 + $1.expenses.reduce(0.0) { $0 + $1.amount } }
    }
    
    // Method to calculate total savings
    func totalSavings() -> Double {
        guard let user = getUser() else { return 0.0 }
        return user.savings.reduce(0.0) { $0 + $1.amount }
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
