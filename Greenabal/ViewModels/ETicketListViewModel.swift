//
//  ETicketListViewModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/14.
//

import Foundation
import SwiftUI

class ETicketListViewModel: ObservableObject{
    @Published var transportList: [TransportList]
    let leafVM: LeafViewModel
    let badgeVM: BadgeViewModel
    let modalVM: ModalViewModel
    
    init(leafVM: LeafViewModel,badgeVM: BadgeViewModel,modalVM: ModalViewModel){
        self.leafVM = leafVM
        self.badgeVM = badgeVM
        self.modalVM = modalVM
        
        let testList: [TransportList] = [
            TransportList(date: "2022/04/19", items: [TransportItem(title: "大都會", time: "19:43"),TransportItem(title: "首都客運", time: "08:12")]),
            TransportList(date: "2022/05/18", items: [TransportItem(title: "台北捷運", time: "20:00"),TransportItem(title: "Youbike", time: "20:20")]),
            TransportList(date: "2022/06/19", items: [TransportItem(title: "大都會", time: "19:43"),TransportItem(title: "首都客運", time: "08:12")])
        ]
        
        transportList = testList
        
        print("--------------transport init-----------------")
        print(transportList)
    }
    
    func GetList(year: Int,startMonth: Int,endMonth: Int) -> [TransportList] {
        // 取得列表
        var result: [TransportList] = []
        transportList.forEach { list in
            let date = list.date.split(separator: "/")
            let startMonthString = startMonth < 10 ? "0\(startMonth)" : String(startMonth)
            let endMonthString = endMonth < 10 ? "0\(endMonth)" : String(endMonth)
            if date[0] == String(year) && (date[1] == startMonthString || date[1] == endMonthString) {
                result.append(list)
            }
        }
        result = result.sorted(by: {
            $0.date > $1.date
        })
        
        print("--------------get transport list-----------------")
        print(result)
        
        return result
    }
    
    func AddItem(date: String, title: String, time: String, leaf: Int = 3, badge: String = BadgeType.youbike.rawValue){
        if let index = transportList.firstIndex(where: { $0.date == date }){
            transportList[index].AddItem(title: title, time: time, leaf: leaf, badge: badge)
            
        }
        else{
            transportList.append(TransportList(date: date, items: [(TransportItem(title: title, time: time, leaf: leaf, badge: badge))]))
        }
        
        print("--------------add transport list 's item-----------------")
        print(transportList)
        
        leafVM.AddCount(num: leaf, record: true)
        badgeVM.RefreshBadge(name: badge)
        modalVM.showTicketModal(data: TransportItem(title: title, time: time, leaf: leaf, badge: badge))
    }
}

