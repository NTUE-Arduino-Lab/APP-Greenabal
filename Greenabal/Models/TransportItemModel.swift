//
//  TransportItem.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/14.
//

import Foundation

struct TransportItem{
    //    電子票證搭乘紀錄
    let date: String
    let leaf: Int
    let title: String
    let time: String
    let badge: String
    
    init(date: String, title: String, time: String, leaf: Int = 3, badge: String = BudgeType.youbike.rawValue){
        self.date = date
        self.title = title
        self.time = time
        self.badge = badge
        self.leaf = leaf
    }
}
