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
    let titles: [String]
    let goalDiscriptions: [String]
    var currentCount: Int
    var getLeafStates: [Bool]
    var goalCounts: [Int]
    var currentStar: Int
    let totalStar: Int
    let images: [String]
    
    init(name: String, titles: [String], goalDiscriptions: [String], image: String, goalCounts: [Int], totalStar: Int = 3, currentCount: Int = 0, currentStar: Int = 0,getLeafStates: [Bool] = [false,false,false]){
        self.name = name
        self.titles = titles
        self.goalDiscriptions = goalDiscriptions
        self.images = ["\(image)_1","\(image)_2","\((image))_3"]
        self.goalCounts = goalCounts
        self.totalStar = totalStar
        self.currentCount = currentCount
        self.currentStar = currentStar
        self.getLeafStates = getLeafStates
    }
    
    func AddCount(){
        currentCount += 1
        if currentCount >= goalCounts[currentStar]{
            AddStar()
        }
    }
    
    func AddStar(){
        if currentStar < totalStar{
            currentStar += 1
        }
    }
    
    func GetReward(star: Int){
        if !getLeafStates[star-1] {
            getLeafStates[star-1] = true
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
        BadgeModel(name: BadgeType.youbike.rawValue,titles: ["見習騎士","城市漫遊者","熱血鐵騎仔"], goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "badge_bicycle", goalCounts: [10,20,50],currentStar: 2),
        BadgeModel(name: BadgeType.bus.rawValue,titles: ["招手攔車","坐在靠窗座","司機都很熟"], goalDiscriptions: ["搭乘達10次","搭乘達20次","搭乘達50次"], image: "badge_bicycle", goalCounts: [10,20,50])
    ]
}
