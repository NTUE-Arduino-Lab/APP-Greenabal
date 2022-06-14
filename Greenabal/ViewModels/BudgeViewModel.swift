//
//  BadgeViewModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/13.
//

import Foundation

enum BadgeType: String {
case youbike = "YouBike 王"
case knowledge = "知識小達人"
case electricity = "省電小達人"
case plastic = "省塑小達人"
case seal_環保 = "環保標章小達人"
case seal_有機 = "有機標章小達人"
}


class BadgeViewModel: ObservableObject{
    @Published var badgeList: [BadgeModel]
    
    init(){
        badgeList = [
            BadgeModel(title: BadgeType.youbike.rawValue, goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "badge_bicycle", goalCounts: [10,20,50],currentStar: 2),
            BadgeModel(title: BadgeType.knowledge.rawValue, goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "badge_bicycle", goalCounts: [10,20,50]),
            BadgeModel(title: BadgeType.electricity.rawValue, goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "badge_bicycle", goalCounts: [10,20,50]),
            BadgeModel(title: BadgeType.plastic.rawValue, goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "badge_bicycle", goalCounts: [10,20,50]),
            BadgeModel(title: BadgeType.seal_環保.rawValue, goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "badge_bicycle", goalCounts: [10,20,50]),
            BadgeModel(title: BadgeType.seal_有機.rawValue, goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "badge_bicycle", goalCounts: [10,20,50]),
        ]
        
//        RefreshBadge(index:0)
        
        print("--------------badge init-----------------")
        badgeList.forEach{ item in
            print(item.title)
            print(item.currentCount)
        }
    }
    
    func RefreshBadge(title: String){
        if let index = badgeList.firstIndex(where: { $0.title == title }){
            badgeList[index].AddCount()
        }
        
        print("-------------refresh badge------------------")
        badgeList.forEach{ item in
            print(item.title)
            print(item.currentCount)
        }
    }
    
    func RefreshBadge(index: Int){
        let badge = badgeList[index]
        badge.AddCount()
        
        print("---------------refresh badge----------------")
        badgeList.forEach{ item in
            print(item.title)
            print(item.currentCount)
        }
    }
}
