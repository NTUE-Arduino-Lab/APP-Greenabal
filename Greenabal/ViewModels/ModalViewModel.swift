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
    @Published var taskData: Task!
    @Published var ticketData: TransportItem!
    @Published var show: Bool
    @Published var type: ModalType
    
    @Published var showSmall: Bool
    @Published var titleSmall: String = ""
    
    var timer: Timer?
    
    init(){
        self.show = false
        self.type = .gift
        self.showSmall = false
    }
    
    func setMedalData(data: BadgeModel){
        medalData = data
    }
    
    func setBuyData(data: BuyItem){
    }
    
    func showGiftModal(data: BuyItem){
        buyData = data
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
    
    func showKnowledgeModal(data: Task){
        taskData = data
        type = .knowledge
        show = true
    }
    
    func showTicketModal(data: TransportItem){
        ticketData = data
        type = .ticket
        show = true
    }
    
    func showSmallModal(title: String){
        titleSmall = title
        showSmall = true
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(hideSmallModal), userInfo: nil, repeats: false)
    }
    
    func hideModal(){
        show = false
    }
    
    @objc func hideSmallModal(){
        showSmall = false
    }
}
