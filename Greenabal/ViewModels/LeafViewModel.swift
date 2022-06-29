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
    let modalVM: ModalViewModel
    
    init(mvm: ModalViewModel){
        let dateViewModel: DateViewModel = DateViewModel()
        self.modalVM = mvm
        
        testRecordList = [
            LeafRecordModel(date: dateViewModel.FormatDateToString(date: Date()), count: 2),
            LeafRecordModel(date: dateViewModel.FormatDateToString(date: Date() + TimeInterval(5*24*60*60)), count: 3),
            LeafRecordModel(date: dateViewModel.FormatDateToString(date: Date() + TimeInterval(5*24*60*60)), count: 2),
            LeafRecordModel(date: dateViewModel.FormatDateToString(date: Date() - TimeInterval(3*24*60*60)), count: 1),
        ]
        
        count = 90
        recordList = testRecordList
        autoIncreseCount = 3
        
        timer = Timer.scheduledTimer(timeInterval: 3600.0, target: self, selector: #selector(AutoIncreaseCount), userInfo: nil, repeats: true)
        
        print("--------------left init-----------------")
        recordList.forEach{ item in
            print("record:\(item.date) : \(item.count)")
        }
        print("left count:\(count)")
    }
    
    private func AddRecord(num:Int){
        //        葉子獲得紀錄
        
        let dateViewModel: DateViewModel = DateViewModel()
        let now: String = dateViewModel.FormatDateToString(date: Date())
        
        if let index = recordList.firstIndex(where: { $0.date == now }){
            recordList[index].addCount(num: num)
        }
        else{
            let record = LeafRecordModel(date: now, count: num)
            recordList.append(record)
        }
        
        print("--------------add leaf record-----------------")
        recordList.forEach{ item in
            print(item.count)
        }
    }
    
    @objc func AutoIncreaseCount(){
        //        葉子自動獲得（每小時）
        AddCount(num: autoIncreseCount,record: false)
        
        print("--------------add leaf record-----------------")
        recordList.forEach{ item in
            print(item.count)
        }
    }
    
    func AddCount(num:Int,record:Bool){
        if record{
            AddRecord(num: num)
        }
        
        count += num
        modalVM.showSmallModal(title: "獲取\(num)片葉子，目前共有\(count)片")
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
            
            if let index = recordList.firstIndex(where: { $0.date == targetDateString }){
                results.append(recordList[index].count)
            }
            else{
                results.append(0)
            }
            
            targetDate.addTimeInterval(60*60*24)
            
        } while targetDate <= endDate
        
        print("--------------get week record-----------------")
        print(results)
        
        return results
    }
}
