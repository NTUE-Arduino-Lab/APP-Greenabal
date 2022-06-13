//
//  BudgeViewModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/13.
//

import Foundation

class BudgeViewModel: ObservableObject{
    @Published var budgelist: [BudgeModel]
    var budgeType: [String] = ["YouBike 王","知識小達人","環保小達人","省電小達人"]
    
    init(){
        budgelist = [
            BudgeModel(title: budgeType[0], goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "budge_bicycle", goalCounts: [10,20,50],currentStar: 3),
            BudgeModel(title: budgeType[1], goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "budge_bicycle", goalCounts: [10,20,50]),
            BudgeModel(title: budgeType[2], goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "budge_bicycle", goalCounts: [10,20,50]),
            BudgeModel(title: budgeType[3], goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "budge_bicycle", goalCounts: [10,20,50]),
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
