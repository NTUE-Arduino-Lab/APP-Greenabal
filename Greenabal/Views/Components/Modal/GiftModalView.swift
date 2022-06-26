//
//  ModalBtn.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/26.
//

import SwiftUI

struct GiftModalContent: View {
    @EnvironmentObject var modalVM: ModalViewModel
    @EnvironmentObject var barcodeVM: BarcodeListViewModel
    @State var btnDisabled: Bool = false
    
    var body: some View {
        VStack{
            
            if modalVM.buyData.gift is GiftIsland {
                let gift: GiftIsland = modalVM.buyData.gift as! GiftIsland
                RewardItem(image: "icon_big_gift", title: "購買\(modalVM.buyData.seal)商品", info: "獲得\(gift.type.rawValue)")
            }
            else if modalVM.buyData.gift is GiftLeaf {
                let gift: GiftLeaf = modalVM.buyData.gift as! GiftLeaf
                RewardItem(image: "icon_big_gift", title: "購買\(modalVM.buyData.seal)商品", info: "獲得 \(gift.leaf) 片葉子")
            }
            
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
        .onChange(of: modalVM.buyData.openGift, perform: { newValue in
            btnDisabled = newValue
        })
        
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(red: 241/255, green: 241/255, blue: 241/255))
            .frame(width: 300,height: 1)
        
        if modalVM.buyData.gift is GiftIsland {
            ModalButton(text: "稀有島嶼", icon: !btnDisabled ? "icon_gift_ticket" : "icon_gift_ticket_gray" , action: BtnAction, disabled: $btnDisabled)
        }
        else if modalVM.buyData.gift is GiftLeaf {
            let item: GiftLeaf = modalVM.buyData.gift as! GiftLeaf
            ModalButton(text: "\(item.leaf)", icon: !btnDisabled ?  "icon_leaf_green" : "icon-leaf-gray-2", action: BtnAction, disabled: $btnDisabled)
        }
    }
    
    func BtnAction(){
        barcodeVM.OpenGift(item: modalVM.buyData)
//        modalVM.hideModal()
        btnDisabled = true
    }
}

struct GiftModalView_Previews: PreviewProvider {
    static var leafVM: LeafViewModel = LeafViewModel()
    static var modalVM: ModalViewModel = ModalViewModel()
    @State static var show: Bool = true
    @State var badgeVM: BadgeViewModel = BadgeViewModel(leafVM: leafVM,modalVM: modalVM)
    
    static var previews: some View {
        ModalView(type: .medal, show: $show)
            .environmentObject(modalVM)
    }
}
