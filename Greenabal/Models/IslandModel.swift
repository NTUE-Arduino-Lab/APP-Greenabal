//
//  IslandModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/21.
//

import Foundation
class IslandModel: Identifiable{
    let id = UUID()
    let name: String
    let number: Int
    var currentLevel: Int
    var totalLevel: Int
    let leafs: [Int]
    var isCompleted: Bool
    var costDay: Int
    let image: String
    
    init(name: String, image: String, number: Int, totalLevel: Int = 5, leafs: [Int]){
        self.name = name
        self.number = number
        self.currentLevel = 1
        self.totalLevel = totalLevel
        self.leafs = leafs
        self.isCompleted = false
        self.costDay = 1
        self.image = image
    }
    
    func getLevelLeaf() -> Int{
        return leafs[currentLevel-1]
    }
    
    func updateLevel(){
        currentLevel += 1
        if currentLevel == totalLevel {
            isCompleted = true
        }
    }
    
    func updateCostDay(){
        costDay += 1
    }
}
