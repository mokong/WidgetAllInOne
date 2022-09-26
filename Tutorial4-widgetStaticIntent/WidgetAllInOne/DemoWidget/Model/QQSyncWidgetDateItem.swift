//
//  QQSyncWidgetDateItem.swift
//  DemoWidgetExtension
//
//  Created by Horizon on 07/06/2022.
//

import Foundation

struct QQSyncWidgetDateItem {
    var year: String
    var month: String
    var day: String
    
    var week: String
    
    var hour: String
    var minute: String
    var second: String
    
    static func generateItem() -> QQSyncWidgetDateItem {
        let dateStr = date2String(date: Date())
        
        let year = dateStr.getFormatDateStr(DisplayDateType.Year)
        let month = dateStr.getFormatDateStr(DisplayDateType.Month)
        let day = dateStr.getFormatDateStr(DisplayDateType.Day)
        
        let week = dateStr.getWeekday()
        
        let hour = dateStr.getFormatDateStr(DisplayDateType.hour)
        let minute = dateStr.getFormatDateStr(DisplayDateType.minute)
        let second = dateStr.getFormatDateStr(DisplayDateType.second)
        
        let item = QQSyncWidgetDateItem(year: year,
                                     month: month,
                                     day: day,
                                     week: week,
                                     hour: hour,
                                     minute: minute,
                                     second: second)
        return item
    }
    
    static func date2String(date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
}
