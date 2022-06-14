//
//  BudgeViewModel.swift
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
    
}

class BudgeViewModel: ObservableObject{
    @Published var budgelist: [BudgeModel]
    
    init(){
        budgelist = [
            BudgeModel(title: BudgeType.youbike.rawValue, goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "budge_bicycle", goalCounts: [10,20,50],currentStar: 3),
            BudgeModel(title: BudgeType.knowledge.rawValue, goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "budge_bicycle", goalCounts: [10,20,50]),
            BudgeModel(title: BudgeType.electricity.rawValue, goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "budge_bicycle", goalCounts: [10,20,50]),
            BudgeModel(title: BudgeType.plastic.rawValue, goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "budge_bicycle", goalCounts: [10,20,50]),
        ]
        
//        RefreshBudge(index:0)
    }
    
    func RefreshBudge(title: String){
        let budge = budgelist.first(where: {$0.title == title})
        budge?.AddCount()
    }
    
    func RefreshBudge(index: Int){
        let budge = budgelist[index]
        budge.AddCount()
    }
}
