//
//  BudgeViewModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/13.
//

import Foundation

class BudgeViewModel: ObservableObject{
    @Published var budgelist: [BudgeModel]
    
    init(){
        budgelist = [
            BudgeModel(title: "YouBike 王", goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "budge_bicycle", goalCounts: [10,20,50],currentStar: 3),
            BudgeModel(title: "test1", goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "budge_bicycle", goalCounts: [10,20,50]),
            BudgeModel(title: "test2", goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "budge_bicycle", goalCounts: [10,20,50]),
            BudgeModel(title: "test3", goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "budge_bicycle", goalCounts: [10,20,50]),
            BudgeModel(title: "test4", goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "budge_bicycle", goalCounts: [10,20,50]),
            BudgeModel(title: "test5", goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "budge_bicycle", goalCounts: [10,20,50]),
            BudgeModel(title: "test6", goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "budge_bicycle", goalCounts: [10,20,50]),
            BudgeModel(title: "test7", goalDiscriptions: ["騎行達10次","騎行達20次","騎行達50次"], image: "budge_bicycle", goalCounts: [10,20,50]),
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
