//
//  BadgeViewModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/13.
//

import Foundation


class BadgeViewModel: ObservableObject{
    @Published var badgeList: [BadgeModel]
    
    init(){
        badgeList = BadgeModel.all
        
        //        RefreshBadge(index:0)
        
        print("--------------badge init-----------------")
        badgeList.forEach{ item in
            print(item.name)
            print(item.currentCount)
        }
    }
    
    func RefreshBadge(name: String){
        if let index = badgeList.firstIndex(where: { $0.name == name }){
            badgeList[index].AddCount()
        }
        
        print("-------------refresh badge------------------")
        badgeList.forEach{ item in
            print(item.name)
            print(item.currentCount)
        }
    }
    
    func RefreshBadge(index: Int){
        let badge = badgeList[index]
        badge.AddCount()
        
        print("---------------refresh badge----------------")
        badgeList.forEach{ item in
            print(item.name)
            print(item.currentCount)
        }
    }
    
    func GetReward(name: String,star: Int){
        if let index = badgeList.firstIndex(where: { $0.name == name }){
            badgeList[index].GetReward(star: star)
        }
    }
}
