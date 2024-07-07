//
//  SubscribeModel.swift
//  FinTask
//
//  Created by Иван Незговоров on 06.07.2024.
//

import Foundation

struct Subscribe {
    var image: String
    var text: String
}

struct SubscribeTable {
    var firstLBL: String
    var secondLBL: String
}

class SubscribeModel {
    var carouselData: [Subscribe] = []
    var tableData: [SubscribeTable] = []
    
    init() {
        downloadData()
    }
    
    func downloadData() {
        carouselData = [Subscribe(image: "unlimitExpense", text: String(localized: "Subscribe_Data_Expense")),
                        Subscribe(image: "unlimitIncome", text: String(localized: "Subscribe_Data_Income")),
                        Subscribe(image: "selectedCurrency", text: String(localized: "Subscribe_Currency_Selection")),
                        Subscribe(image: "fewWallet", text: String(localized: "Subscribe_Multiple_Accounts"))]
        tableData = [SubscribeTable(firstLBL: String(localized: "Subscribe_DataFirst_First"), secondLBL: String(localized: "Subscribe_Data_FIrst_Second")),
                     SubscribeTable(firstLBL: String(localized: "Subscribe_Data_Second_First"), secondLBL: String(localized: "Subscribe_Data_Second_Second")),
                     SubscribeTable(firstLBL: String(localized: "Subscribe_Data_Third_First"), secondLBL: String(localized: "Subscribe_Data_Third_Second")),
        ]
    }
}
