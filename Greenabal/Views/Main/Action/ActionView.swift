//
//  ActionView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/8.
//

import SwiftUI

extension AnyTransition {
    static var viewMoveTrailing: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading)
        )
    }
    static var viewMoveLeading: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .leading),
            removal: .move(edge: .trailing)
        )
    }
}



struct MonthSelector: View{
    var body: some View {
        Text("111 年 5-6 月")
            .font(.custom("Roboto-Medium", size: 14))
            .tracking(0.56)
            .padding(.top,25)
            .padding(.bottom,10)
    }
}

struct ActionView: View {
    @EnvironmentObject var backgroundViewModel: BackgroundViewModel
    
    private let title = "環保行動"
    private let name = "Action"
    private var tabs = ["手機載具","電子票證"]
    @State var tabTarget: Int = 1
    
    var body: some View {
        VStack(spacing:0){
            Header(title: title, name: name)
            
            ZStack(alignment: .bottom){
                if tabTarget == 0 {
                    BarcodeView()
                }
                else{
                    ETicketView()
                }
                
                SubTabBar(tabs:tabs,tabTarget: $tabTarget)
                
            }
            .padding([.bottom],93)
        }
        .background(backgroundViewModel.color)
        .clipped()
    }
}

struct ActionView_Previews: PreviewProvider {
    static let backgroundViewModel = BackgroundViewModel()
    static var leafViewModel:LeafViewModel = LeafViewModel()
    static var badgeViewModel:BadgeViewModel = BadgeViewModel()
    static var barcodeListViewModel:BarcodeListViewModel = BarcodeListViewModel(leafViewModel: leafViewModel, badgeViewModel: badgeViewModel)
    
    static var previews: some View {
        TabBar(initSelectedTab: "Action").environmentObject(backgroundViewModel)
            .environmentObject(barcodeListViewModel)
    }
}
