//
//  ModalViewModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/25.
//

import Foundation

class ModalViewModel: ObservableObject{
    @Published var medalData: BadgeModel!
    @Published var buyData: BuyItem!
    @Published var show: Bool
    @Published var type: ModalType
    
    init(){
        self.show = false
        self.type = .gift
    }
    
    func setMedalData(data: BadgeModel){
        medalData = data
    }
    
    func setBuyData(data: BuyItem){
        buyData = data
    }
    
    func showGiftModal(data: BuyItem){
        setBuyData(data: data)
        type = .gift
        show = true
    }
    
    func showMedalModal(data: BadgeModel){
        setMedalData(data: data)
        type = .medal
        show = true
    }
    
    func showGetMedalModal(data: BadgeModel){
        setMedalData(data: data)
        type = .getMedal
        show = true
    }
    
    func hideModal(){
        show = false
    }
}
