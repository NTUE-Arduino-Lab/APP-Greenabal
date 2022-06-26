//
//  DateViewModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/13.
//

import Foundation

struct DateViewModel {
    let dateFormatter: DateFormatter = DateFormatter()
    
    init(){
        dateFormatter.locale = Locale(identifier: "zh_Hant_TW") // 設定地區(台灣)
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Taipei") // 設定時區(台灣)
//        dateFormatter.calendar = Calendar(identifier: .chinese)
    }
    
    func FormatDateToString(date: Date) -> String{
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        return dateFormatter.string(from: date)
    }
    
    func GetWeekDay(fromNow: Int) -> (Date,Date,String){
        let today = Date() + TimeInterval(fromNow*7*24*60*60)
        let calendar = Calendar.current
        
        let todayWeekday = calendar.component(.weekday, from: today)
        
        var components = DateComponents()
        
        components.weekday = 1 - todayWeekday
        let SundayDate = calendar.date(byAdding: components, to: today) ?? Date()
        
        components.weekday = 7 - todayWeekday
        let SaturdayDate = calendar.date(byAdding: components, to: today) ?? Date()
        
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        let SundayString = dateFormatter.string(from: SundayDate)
        
//        let Sunday = dateFormatter.string(from: SundayDate)
//        
//        let Saturday = dateFormatter.string(from: SaturdayDate)
        
        dateFormatter.dateFormat = "MM/dd"
        
        let SaturdayString = dateFormatter.string(from: SaturdayDate)
        
        return (SundayDate,SaturdayDate,"\(SundayString) - \(SaturdayString)")
    }
}
