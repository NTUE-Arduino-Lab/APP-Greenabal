//
//  LeafViewModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/13.
//

import Foundation

class LeafViewModel: ObservableObject{
    @Published var count: Int
    @Published private var recordList: [LeafRecordModel]
    let autoIncreseCount: Int
    var timer: Timer?
    let testRecordList: [LeafRecordModel]
    
    init(){
        let dateViewModel: DateViewModel = DateViewModel()
        
        testRecordList = [
            LeafRecordModel(date: dateViewModel.FormatDateToString(date: Date()), count: 5)
        ]
        
        count = 5
        recordList = testRecordList
        autoIncreseCount = 3
        
        let result = dateViewModel.GetWeekDay(fromNow: 0)
        print(result)
        
        print(GetWeekRecord(startDate: result.0, endDate: result.1))
        
        AddRecord(num: 2)
        
        print(GetWeekRecord(startDate: result.0, endDate: result.1))
    }
    
    private func AddRecord(num:Int){
        //        葉子獲得紀錄
        
        let dateViewModel: DateViewModel = DateViewModel()
        let now: String = dateViewModel.FormatDateToString(date: Date())
        
        let oldRecord = recordList.first(where: {$0.date == now})
        
        if oldRecord != nil {
            oldRecord?.addCount(num: num)
        }else {
            let record = LeafRecordModel(date: now, count: num)
            recordList.append(record)
        }
        
    }
    
    @objc func AutoIncreaseCount(){
        //        葉子自動獲得（每小時）
        AddCount(num: autoIncreseCount,record: false)
    }
    
    func AddCount(num:Int,record:Bool){
        if record{
            AddRecord(num: num)
        }
        
        count += num
    }
    
    func ReduceCount(num:Int){
        count -= num
    }
    
    func GetWeekRecord(startDate: Date,endDate: Date) -> [Int]{
        let dateViewModel: DateViewModel = DateViewModel()
        
        var targetDate: Date = startDate
        
        var results:[Int] = []
        
        repeat {
            let targetDateString: String = dateViewModel.FormatDateToString(date: targetDate)
            
            let record = recordList.first(where: {$0.date == targetDateString})
            
            results.append(record?.count ?? 0)
            
            targetDate.addTimeInterval(60*60*24)
            
        } while targetDate <= endDate
        
        return results
    }
}
