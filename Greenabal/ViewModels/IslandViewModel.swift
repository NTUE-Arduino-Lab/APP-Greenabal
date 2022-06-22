//
//  IslandViewModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/21.
//

import Foundation

class IslandViewModel: ObservableObject{
    @Published var islandList: [IslandModel] = []
    @Published var currentIsland: IslandModel
    @Published var currentIslandIndex: Int
    let leafVM: LeafViewModel
    
    init(leafVM: LeafViewModel){
        self.leafVM = leafVM
        
        let newList = [
            IslandModel(name: "初來乍島",image: "Island_L", number: 168, leafs: [10,50,75,100,200])
        ]
        
        islandList = newList
        
        currentIslandIndex = 0
        currentIsland = newList[0]
    }
    
    func updateIsland(){
        if currentIsland.currentLevel <= currentIsland.totalLevel - 1 {
            leafVM.ReduceCount(num: currentIsland.getLevelLeaf())
            currentIsland.updateLevel()
        }
    }
}
