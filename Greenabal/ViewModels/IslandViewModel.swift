//
//  IslandViewModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/21.
//

import Foundation

class IslandViewModel: ObservableObject{
    @Published var islandList: [IslandModel] = []
    @Published var currentIslandIndex: Int = 0
    let leafVM: LeafViewModel
    
    init(leafVM: LeafViewModel){
        self.leafVM = leafVM
        
        islandList = [
            IslandModel(name: "初來乍島", number: 168, leafs: [10,50,100,250,500])
        ]
    }
}
