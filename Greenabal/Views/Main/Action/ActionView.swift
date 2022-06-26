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

struct MonthSelection {
    let year: Int
    let month: Int
}

struct MonthSelector: View {
    let months: [MonthSelection]
    @Binding var selectedIndex: Int
    
    var body: some View {
        Menu(content: {
            Picker(selection: $selectedIndex) {
                ForEach(months.indices, id: \.self) { index in
                    Text("\(String(months[index].year)) 年 \(months[index].month) - \(months[index].month+1) 月")
                        .font(.custom("Roboto-Medium", size: 14))
                        .tracking(0.56)
                }
            } label: {
                Text("aa")
                    .font(.custom("Roboto-Medium", size: 14))
                    .tracking(0.56)
            }
        }, label: {
            Text("\(String(months[selectedIndex].year)) 年 \(months[selectedIndex].month)-\(months[selectedIndex].month+1) 月")
                .font(.custom("Roboto-Medium", size: 14))
                .tracking(0.56)
            Image("icon_dropdown")
        })
        .foregroundColor(Color.black)
        .padding(.top,10)
        .padding(.bottom,10)
    }
}


struct ActionView: View {
    let months: [MonthSelection] = [
        MonthSelection(year: 2022, month: 5),
        MonthSelection(year: 2022, month: 3),
    ]
    @State private var title = "環保行動"
    private let name = "Action"
    private var tabs = ["手機載具","電子票證"]
    @State var tabTarget: Int = 0
    @State var selectedIndex: Int = 0
    
    var body: some View {
        VStack(spacing:0){
            Header(title: $title, name: name)
            
            ZStack(alignment: .bottom){
                if tabTarget == 0 {
                    BarcodeView(selectedIndex: $selectedIndex,months: months)
                }
                else{
                    ETicketView(selectedIndex: $selectedIndex,months: months)
                }
                
                SubTabBar(tabs:tabs,tabTarget: $tabTarget)
                
            }
            .padding([.bottom],93)
            .padding([.top],20)
        }
    }
}

struct ActionView_Previews: PreviewProvider {
    static var leafVM:LeafViewModel = LeafViewModel()
    static var modalVM: ModalViewModel = ModalViewModel()
    static var badgeVM: BadgeViewModel = BadgeViewModel(leafVM: leafVM,modalVM: modalVM)
    static var barcodeListVM:BarcodeListViewModel = BarcodeListViewModel(leafVM: leafVM, badgeVM: badgeVM)
    static var eTicketListVM: ETicketListViewModel = ETicketListViewModel(leafVM: leafVM, badgeVM: badgeVM)
    
    static var previews: some View {
        TabBar(initSelectedTab: "Action")
            .environmentObject(barcodeListVM)
            .environmentObject(eTicketListVM)
            .environmentObject(modalVM)
    }
}
