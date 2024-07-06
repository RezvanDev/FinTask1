//
//  CurrencyModel.swift
//  FinTask
//
//  Created by Иван Незговоров on 06.07.2024.
//

import Foundation

struct Currency {
    var name: String
}

class CurrencyModel {
    var currencies: [(name: String, code: String)] = []
    
    init() {
        downloadCurrencies()
    }
    
    func downloadCurrencies() {
        currencies = [(name: "Казахстанских тенге", code: "KZT"),
        (name: "Российский рубль", code: "RUB"),
        (name: "Белорусский рубль", code: "BYN"),
        (name: "Грузинский лари", code: "GEL"),
        (name: "Украинская гривна", code: "UAH"),
        (name: "Армянский драм", code: "AMD"),
        (name: "Азербайджанский манат", code: "AZN"),
        (name: "Евро", code: "EUR"),
        (name: "Доллар США", code: "USD")]
    }
    
}
