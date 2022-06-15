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
//        .background(LinearGradient(
//            gradient: Gradient(stops: [
//                .init(color: Color(#colorLiteral(red: 0.6102343797683716, green: 0.7855484485626221, blue: 0.9125000238418579, alpha: 1)), location: 0),
//                .init(color: Color(#colorLiteral(red: 0.915928840637207, green: 0.9526067972183228, blue: 0.9791666865348816, alpha: 1)), location: 1)]),
//            startPoint: UnitPoint(x: 0.5, y: -3.0616171314629196e-17),
//            endPoint: UnitPoint(x: 0.5, y: 0.9999999999999999))
//        )
    }
}

struct ActionView_Previews: PreviewProvider {
    static var leafViewModel:LeafViewModel = LeafViewModel()
    static var badgeViewModel:BadgeViewModel = BadgeViewModel()
    static var barcodeListViewModel:BarcodeListViewModel = BarcodeListViewModel(leafViewModel: leafViewModel, badgeViewModel: badgeViewModel)
    static var eTicketListViewModel: ETicketListViewModel = ETicketListViewModel(leafViewModel: leafViewModel, badgeViewModel: badgeViewModel)
    
    static var previews: some View {
        TabBar(initSelectedTab: "Action")
            .environmentObject(barcodeListViewModel)
            .environmentObject(eTicketListViewModel)
    }
}
