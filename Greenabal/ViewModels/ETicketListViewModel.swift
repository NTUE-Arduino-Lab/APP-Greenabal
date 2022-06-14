//
//  ETicketListViewModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/14.
//

import Foundation

class ETicketListViewModel: ObservableObject{
    @Published var transportList: [TransportItem]
    
    init(){
        let testList: [TransportItem] = [
            TransportItem(date: "2022/05/18", title: "台北捷運", time: "20:00"),
            TransportItem(date: "2022/05/18", title: "Youbike", time: "20:20"),
            TransportItem(date: "2022/06/19", title: "大都會", time: "19:43"),
            TransportItem(date: "2022/06/19", title: "首都客運", time: "08:12"),
        ]
        
        transportList = testList
        
        print(getList(year: 2022, startMonth: 5,endMonth: 6))
        
    }
    
    func getList(year: Int,startMonth: Int,endMonth: Int) -> [TransportItem] {
        //        取得列表
        var result: [TransportItem] = []
        transportList.forEach { item in
            let date = item.date.split(separator: "/")
            let startMonthString = startMonth < 10 ? "0\(startMonth)" : String(startMonth)
            let endMonthString = endMonth < 10 ? "0\(endMonth)" : String(endMonth)
            if date[0] == String(year) && (date[1] == startMonthString || date[1] == endMonthString) {
                result.append(item)
            }
        }
        result = result.sorted(by: {
            $0.time < $1.time
        })
        return result
    }
}

