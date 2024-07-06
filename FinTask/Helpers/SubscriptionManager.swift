//
//  SubscriptionManager.swift
//  FinTask
//
//  Created by Иван Незговоров on 06.07.2024.
//

import Foundation
import StoreKit

class SubscriptionManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    static let shared = SubscriptionManager()

    var products: [SKProduct] = []
    
    private override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    func fetchProducts() {
        let productIDs = Set(["com.yourapp.monthly", "com.yourapp.threemonths", "com.yourapp.lifetime"])
        let request = SKProductsRequest(productIdentifiers: productIDs)
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        products = response.products
    }
    
    func buyProduct(_ product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                // Обработка успешной покупки
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed:
                // Обработка неудачной транзакции
                if let error = transaction.error {
                    print("Транзакция не удалась: \(error.localizedDescription)")
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                // Обработка восстановленной покупки
                SKPaymentQueue.default().finishTransaction(transaction)
            case .deferred, .purchasing:
                break
            @unknown default:
                break
            }
        }
    }
}
