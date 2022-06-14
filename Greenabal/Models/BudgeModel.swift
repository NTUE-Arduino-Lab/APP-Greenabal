//
//  BudgeModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/13.
//

import Foundation

enum BudgeType: String {
case youbike = "YouBike 王"
case knowledge = "知識小達人"
case electricity = "省電小達人"
case plastic = "省塑小達人"
case seal_環保 = "環保標章小達人"
case seal_有機 = "有機標章小達人"
}

class BudgeModel: Identifiable{
    //    徽章
    let id = UUID()
    let title: String
    let goalDiscriptions: [String]
    var currentCount: Int
    var goalCounts: [Int]
    var currentStar: Int
    let totalStar: Int
    let images: [String]
    
    init(title: String, goalDiscriptions: [String], image: String, goalCounts: [Int], totalStar: Int = 3, currentCount: Int = 0, currentStar: Int = 0){
        self.title = title
        self.goalDiscriptions = goalDiscriptions
        self.images = ["\(image)_1","\(image)_2","\((image))_3"]
        self.goalCounts = goalCounts
        self.totalStar = totalStar
        self.currentCount = currentCount
        self.currentStar = currentStar
    }
    
    func AddCount(){
        currentCount += 1
        if currentCount >= goalCounts[currentStar]{
            AddStar()
        }
    }
    
    func AddStar(){
        currentStar += 1
    }
}
