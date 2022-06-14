//
//  LeafRecordModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/13.
//

import Foundation

struct LeafRecordModel: Identifiable{
//    葉子獲取紀錄
    let id = UUID()
    let date: String
    var count: Int
    
    init(date: String,count: Int){
        self.date = date
        self.count = count
    }
    
    mutating func addCount(num: Int){
        count = count + num
    }
}
