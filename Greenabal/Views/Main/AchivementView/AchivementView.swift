//
//  AchivementView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/8.
//

import SwiftUI

struct AchivementView: View {
    @State private var title = "成就"
    private let name = "Achivement"
    private var tabs = ["環保行動","島嶼圖鑑"]
    @State var tabTarget: Int = 0
    
    var body: some View {
        ZStack{
            VStack{
                Header(title: $title, name: name)
                
                VStack{
                    ZStack(alignment: .bottom){
                        if tabTarget == 0 {
                            ScrollView(.vertical,showsIndicators:false){
                                VStack(spacing: 18){
                                    RecordBlock()
                                    
                                    AchivementBlock()
                                }
                                Text("")
                                    .frame(width: 200, height: 70)
                                    .background(Color.clear)
                            }
                        }
                        else{
                            IslandCollection()
                        }
                        
                        SubTabBar(tabs:tabs,tabTarget: $tabTarget)
                        
                    }
                    .padding([.bottom],93)
                    
                } .frame(maxWidth: .infinity,
                         maxHeight: .infinity,
                         alignment: .center)
            }
        }
        
    }
}

struct AchivementView_Previews: PreviewProvider {
    static var modalVM: ModalViewModel = ModalViewModel()
    static var leafVM:LeafViewModel = LeafViewModel(mvm: modalVM)
    static var badgeVM: BadgeViewModel = BadgeViewModel(leafVM: leafVM,modalVM: modalVM)
    
    static var previews: some View {
        TabBar(initSelectedTab: "Achivement")
            .environmentObject(leafVM)
            .environmentObject(badgeVM)
            .environmentObject(modalVM)
    }
}





