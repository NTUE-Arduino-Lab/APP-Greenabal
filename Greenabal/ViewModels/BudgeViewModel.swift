//
//  BadgeViewModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/13.
//

import Foundation


class BadgeViewModel: ObservableObject{
    @Published var badgeList: [BadgeModel]
    let modalVM: ModalViewModel
    let leafVM: LeafViewModel
    
    init(leafVM: LeafViewModel,modalVM: ModalViewModel){
        badgeList = BadgeModel.all
        self.modalVM = modalVM
        self.leafVM = leafVM
        modalVM.medalData = badgeList[0]
        
        //        RefreshBadge(index:0)
        
        print("--------------badge init-----------------")
        badgeList.forEach{ item in
            print(item.name)
            print(item.currentCount)
        }
    }
    
    func RefreshBadge(name: String){
        var result: Bool = false
        let index = badgeList.firstIndex(where: { $0.name == name })
        
        if index != nil {
            result = badgeList[index!].AddCount()
            
            if result {
                modalVM.showGetMedalModal(data: badgeList[index!])
            }
        }
        
        print("-------------refresh badge------------------")
        badgeList.forEach{ item in
            print(item.name)
            print(item.currentCount)
        }
    }
    
    func RefreshBadge(index: Int){
        let badge = badgeList[index]
        let result = badge.AddCount()
        
        if result {
            modalVM.showGetMedalModal(data: badge)
        }
        
        print("---------------refresh badge----------------")
        badgeList.forEach{ item in
            print(item.name)
            print(item.currentCount)
        }
    }
    
    func GetReward(name: String,star: Int){
        if let index = badgeList.firstIndex(where: { $0.name == name }){
            badgeList[index].GetReward(star: star)
            
            leafVM.AddCount(num: badgeList[index].items[star-1].leafReward, record: false)
            
            print("get badge reward")
        }
    }
}
