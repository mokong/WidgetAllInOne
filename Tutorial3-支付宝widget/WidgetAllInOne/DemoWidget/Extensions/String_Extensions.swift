//
//  String_Extensions.swift
//  DemoWidgetExtension
//
//  Created by MorganWang on 07/06/2022.
//

import Foundation

enum DisplayDateType {
    case Year
    case Month
    case Day
    case hour
    case minute
    case second
}

extension String {
    func getFormatDateStr(_ type: DisplayDateType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let formatDate = dateFormatter.date(from: self) else { return "" }
        let calendar = Calendar.current
        _ = calendar.component(.era, from: formatDate)
        let year = calendar.component(.year, from: formatDate)
        let month = calendar.component(.month, from: formatDate)
        let day = calendar.component(.day, from: formatDate)
        let hour = calendar.component(.hour, from: formatDate)
        let minute = calendar.component(.minute, from: formatDate)
        let second = calendar.component(.second, from: formatDate)
        switch type {
        case .Year:
            return String(format: "%.2zd", year)
        case .Month:
            return String(format: "%.2zd", month)
        case .Day:
            return String(format: "%.2zd", day)
        case .hour:
            return String(format: "%.2zd", hour)
        case .minute:
            return String(format: "%.2zd", minute)
        case .second:
            return String(format: "%.2zd", second)
        }
    }

    
    func getWeekday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let formatDate = dateFormatter.date(from: self) else { return "" }
        let calendar = Calendar.current
        let weekDay = calendar.component(.weekday, from: formatDate)
        switch weekDay {
        case 1:
            return "周日"
        case 2:
            return "周一"
        case 3:
            return "周二"
        case 4:
            return "周三"
        case 5:
            return "周四"
        case 6:
            return "周五"
        case 7:
            return "周六"
        default:
            return ""
        }
    }
}
