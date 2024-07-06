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
        carouselData = [Subscribe(image: "unlimitExpense", text: "Безлимитные расходы"),
                        Subscribe(image: "unlimitIncome", text: "Безлимитные доходы"),
                        Subscribe(image: "selectedCurrency", text: "Выбор валюты"),
                        Subscribe(image: "fewWallet", text: "Несколько счетов")]
        tableData = [SubscribeTable(firstLBL: "ГОДОВАЯ ПОДПИСКА", secondLBL: "US$12,99 в год"),
                     SubscribeTable(firstLBL: "МЕСЯЧНАЯ ПОДПИСКА", secondLBL: "Всего US$3,99 в месяц"),
                     SubscribeTable(firstLBL: "НАВСЕГДА", secondLBL: "US$29,99 один раз"),
        ]
    }
}
