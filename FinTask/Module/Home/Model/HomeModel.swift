//
//  HomeModel.swift
//  FinTask
//
//  Created by Иван Незговоров on 24.06.2024.
//

import UIKit

struct HomeModelCell {
    var image: UIImage
    var title: String
}

class HomeModelCellMockData {
    
    var homeModelCells: [HomeModelCell] = []
    
    init(){
        getMockData()
    }
    
    private func getMockData() {
        homeModelCells.append(HomeModelCell(image: UIImage(resource: .income), title: String(localized: "Main_Cell_Income")))
        homeModelCells.append(HomeModelCell(image: UIImage(resource: .expenses), title: String(localized: "Main_Cell_Expense")))
        homeModelCells.append(HomeModelCell(image: UIImage(resource: .habits), title: String(localized: "Main_Cell_Savings")))
        homeModelCells.append(HomeModelCell(image: UIImage(resource: .events), title: String(localized: "Main_Cell_Monthly_Payment")))
    }
}

class HomeModelDate {
    
    func timeUntilEndOfDay() -> String {
        let calendar = Calendar.current
        let now = Date()
        
        guard let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: now) else {
            return "Ошибка вычисления времени"
        }
        
        let components = calendar.dateComponents([.hour, .minute, .second], from: now, to: endOfDay)
        
        guard let hours = components.hour, let minutes = components.minute else {
            return "Ошибка вычисления времени"
        }
        
        return "\(String(localized: "Main_Time")) \(hours) \(hourDeclension(for: hours)) \(minutes) \(minuteDeclension(for: minutes))"
    }
    
    private func hourDeclension(for hours: Int) -> String {
        switch hours % 10 {
        case 1:
            return (hours % 100 == 11) ? String(localized: "Main_Time_Hour1") : String(localized: "Main_Time_Hour")
        case 2, 3, 4:
            return (11...14 ~= hours % 100) ? String(localized: "Main_Time_Hour1") : String(localized: "Main_Time_Hour2")
        default:
            return String(localized: "Main_Time_Hour1")
        }
    }
    
    private func minuteDeclension(for minutes: Int) -> String {
        switch minutes % 10 {
        case 1:
            return (minutes % 100 == 11) ? String(localized: "Main_Time_Minute") : String(localized: "Main_Time_Minute1")
        case 2, 3, 4:
            return (11...14 ~= minutes % 100) ? String(localized: "Main_Time_Minute") : String(localized: "Main_Time_Minute2")
        default:
            return String(localized: "Main_Time_Minute3")
        }
    }
}
