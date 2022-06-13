//
//  LeafRecordModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/13.
//

import Foundation

class LeafRecordModel: Identifiable{
//    葉子獲取紀錄
    let id = UUID()
    let date: String
    var count: Int
    
    init(date: String,count: Int){
        self.date = date
        self.count = count
    }
    
    func addCount(num: Int){
        count = count + num
    }
}
