//
//  LeafViewModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/13.
//

import Foundation

class LeafViewModel: ObservableObject{
    @Published var count: Int
    @Published var recordList: [LeafRecordModel]
    let autoIncreseCount: Int
    var timer: Timer?
    
    init(){
        count = 5
        recordList = []
        autoIncreseCount = 3
        
        timer = Timer.scheduledTimer(timeInterval: 3600.0, target: self, selector: #selector(AutoIncreaseCount), userInfo: nil, repeats: true)
    }
    
    private func AddRecord(num:Int){
//        葉子獲得紀錄
        let record = LeafRecordModel(date: Date(), count: num)
        recordList.append(record)
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
}
