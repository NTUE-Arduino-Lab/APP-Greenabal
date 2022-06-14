//
//  TransportItem.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/14.
//

import Foundation

struct TransportList: Identifiable{
    //    電子票證搭乘紀錄
    let id = UUID()
    let date: String
    var items: [TransportItem]
    
    init(date: String,items: [TransportItem]){
        self.date = date
        self.items = items
    }
    
    mutating func AddItem(title: String,time: String, leaf: Int, badge: String){
        self.items.append(TransportItem(title: title, time: time,leaf: leaf,badge: badge))
    }
}

struct TransportItem: Identifiable{
    //    電子票證搭乘紀錄
    let id = UUID()
    let leaf: Int
    let title: String
    let time: String
    let badge: String
    
    init(title: String, time: String, leaf: Int = 3, badge: String = BadgeType.youbike.rawValue){
        self.title = title
        self.time = time
        self.badge = badge
        self.leaf = leaf
    }
}
