//
//  DetailsViewModel.swift
//  FrostBite
//
//  Created by TaqieAllah on 02/06/2026.
//

import Foundation
import Combine

@MainActor
final class DetailViewModel: ObservableObject {
    
    let day: ForecastDayDTO
    
    init(day: ForecastDayDTO) {
        self.day = day
    }
    
    var hourlyItems: [HourDTO] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let now = Date()
        let calendar = Calendar.current
        
        if let firstHour = day.hour.first,
           let firstDate = formatter.date(from: firstHour.time),
           calendar.isDate(firstDate, inSameDayAs: now) {
            
            let currentHour = calendar.component(.hour, from: now)
            
            return day.hour.filter { item in
                guard let date = formatter.date(from: item.time) else { return false }
                let itemHour = calendar.component(.hour, from: date)
                return itemHour >= currentHour
            }
        } else {
            return day.hour
        }
    }
    
    func hourTitle(for item: HourDTO, index: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let date = formatter.date(from: item.time) else {
            return item.time
        }
        
        if index == 0 && Calendar.current.isDateInToday(date) {
            let currentHour = Calendar.current.component(.hour, from: Date())
            let itemHour = Calendar.current.component(.hour, from: date)
            
            if itemHour == currentHour {
                return "Now"
            }
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "h a"
        return outputFormatter.string(from: date)
    }
}
