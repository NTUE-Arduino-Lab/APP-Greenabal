//
//  TicketModalView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/27.
//

import SwiftUI

struct TicketModalContent: View {
    @EnvironmentObject var modalVM: ModalViewModel
    @EnvironmentObject var eTicketVM: ETicketListViewModel
    @State var btnDisabled: Bool = false
    
    var body: some View {
        VStack{
            RewardItem(image: "icon_big_leaf", title: "搭乘大眾交通運輸工具", info: "獲得 \(modalVM.ticketData.leaf) 片葉子")
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
    }
}

struct TicketModalView_Previews: PreviewProvider {
    static var modalVM: ModalViewModel = ModalViewModel()
    static var leafVM: LeafViewModel = LeafViewModel(mvm: modalVM)
    @State static var show: Bool = true
    @State var badgeVM: BadgeViewModel = BadgeViewModel(leafVM: leafVM,modalVM: modalVM)
    static var previews: some View {
        ModalView(type: .ticket, show: $show)
            .environmentObject(modalVM)
    }
}
