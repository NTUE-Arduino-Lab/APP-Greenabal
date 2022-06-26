//
//  BadgeModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/13.
//

import Foundation

class BadgeModel: Identifiable{
    //    徽章
    let id = UUID()
    let name: String
    var items: [BadgeItemModel]
    var currentCount: Int
    var currentStar: Int
    let totalStar: Int
    
    init(name: String,items: [BadgeItemModel], totalStar: Int = 3, currentCount: Int = 0, currentStar: Int = 0){
        self.name = name
        self.items = items
        self.totalStar = totalStar
        self.currentCount = currentCount
        self.currentStar = currentStar
    }
    
    func AddCount() -> Bool{
        currentCount += 1
        let goalCount = items[currentStar].goalCount
        if currentCount >= goalCount{
            return AddStar()
        }
        return false
    }
    
    func AddStar() -> Bool{
        if currentStar < totalStar{
            currentStar += 1
            return true
        }
        return false
    }
    
    func GetReward(star: Int){
        items[star-1].GetReward()
    }
}

class BadgeItemModel: Identifiable{
    //    徽章
    let id = UUID()
    let title: String
    let goalDiscription: String
    var getLeafState: Bool
    var goalCount: Int
    let image: String
    let leafReward: Int
    
    init(title: String, goalDiscription: String, image: String, goalCount: Int, leafReward: Int,getLeafState: Bool = false ){
        self.title = title
        self.goalDiscription = goalDiscription
        self.image = image
        self.goalCount = goalCount
        self.getLeafState = getLeafState
        self.leafReward = leafReward
    }
    
    func GetReward(){
        if !getLeafState {
            getLeafState = true
        }
    }
}

enum BadgeType: String {
    case youbike = "YouBike"
    case bus = "Bus"
    case knowledge = "知識小達人"
    case electricity = "省電小達人"
    case plastic = "省塑小達人"
    case seal_環保 = "環保標章小達人"
    case seal_有機 = "有機標章小達人"
}

extension BadgeModel {
    static let all: [BadgeModel] = [
        BadgeModel(name: BadgeType.youbike.rawValue,
                   items: [
                    BadgeItemModel(title: "見習騎士", goalDiscription: "騎行達10次", image: "medal-bike-1", goalCount: 10, leafReward: 10),
                    BadgeItemModel(title: "城市漫遊者", goalDiscription: "騎行達20次", image: "medal-bike-2", goalCount: 20, leafReward: 20),
                    BadgeItemModel(title: "熱血鐵騎仔", goalDiscription: "騎行達50次", image: "medal-bike-3", goalCount: 50, leafReward: 50)
                   ],
                   currentCount: 9,currentStar:0),
        BadgeModel(name: BadgeType.bus.rawValue,
                   items: [
                    BadgeItemModel(title: "招手攔車", goalDiscription: "搭乘達10次", image: "medal-bus-1", goalCount: 10, leafReward: 10),
                    BadgeItemModel(title: "坐在靠窗座", goalDiscription: "搭乘達20次", image: "medal-bus-2", goalCount: 20, leafReward: 20),
                    BadgeItemModel(title: "司機都很熟", goalDiscription: "搭乘達50次", image: "medal-bus-3", goalCount: 50, leafReward: 50)
                   ],
                   currentStar:2)
    ]
}
