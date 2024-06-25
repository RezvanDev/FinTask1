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
        homeModelCells.append(HomeModelCell(image: UIImage(resource: .income), title: "Доход"))
        homeModelCells.append(HomeModelCell(image: UIImage(resource: .expenses), title: "Расход"))
        homeModelCells.append(HomeModelCell(image: UIImage(resource: .habits), title: "Накопления"))
        homeModelCells.append(HomeModelCell(image: UIImage(resource: .events), title: "рент"))
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
        
        return "До конца дня осталось \(hours) \(hourDeclension(for: hours)) \(minutes) \(minuteDeclension(for: minutes))"
    }
    
    private func hourDeclension(for hours: Int) -> String {
        switch hours % 10 {
        case 1:
            return (hours % 100 == 11) ? "часов" : "час"
        case 2, 3, 4:
            return (11...14 ~= hours % 100) ? "часов" : "часа"
        default:
            return "часов"
        }
    }
    
    private func minuteDeclension(for minutes: Int) -> String {
        switch minutes % 10 {
        case 1:
            return (minutes % 100 == 11) ? "минут" : "минута"
        case 2, 3, 4:
            return (11...14 ~= minutes % 100) ? "минут" : "минуты"
        default:
            return "минут"
        }
    }
}
