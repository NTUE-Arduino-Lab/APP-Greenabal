//
//  ETicketView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/12.
//

import SwiftUI

struct TransportItemView: View {
    let data: TransportItem
    
    var body: some View {
        HStack(alignment: .center, spacing: 32){
            Text(data.title)
                .font(.custom("Roboto-Regular", size: 14))
                .tracking(0.56)
                .frame(maxWidth: .infinity, alignment:.leading)
            
            Text(data.time)
                .font(.custom("Roboto-Regular", size: 14))
                .tracking(0.56)
            
            HStack(alignment:.center, spacing:4){
                
                Text(String(data.leaf))
                    .font(.custom("Roboto-Bold", size: 14))
                    .tracking(0.56)
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color(#colorLiteral(red: 0.06906247138977051, green: 0.9208333492279053, blue: 0.7675145268440247, alpha: 1)), location: 0.15625),
                                .init(color: Color(#colorLiteral(red: 0.028055548667907715, green: 0.8416666388511658, blue: 0.2558666467666626, alpha: 1)), location: 1)]),
                            startPoint: UnitPoint(x: -1.3877787807814457e-15, y: -1.3877787807814457e-15),
                            endPoint: UnitPoint(x: 1.000000029802322, y: 1.000000029802322))
                        .mask(
                            Text(String(data.leaf))
                                .font(.custom("Roboto-Bold", size: 14))
                                .tracking(0.56)
                        )
                    )
                
                Image("icon_leaf_green")
            }
        }
        .padding([.leading],15)
        .padding([.trailing],20)
        .frame(height: 50)
    }
}

struct ETicketItemView: View {
    let data: TransportList
    
    var body: some View {
        VStack(alignment:.leading, spacing: 0){
            HStack(alignment:.center, spacing: 16){
                Image("icon_ticket")
                Text(data.date.suffix(from: data.date.index(data.date.endIndex, offsetBy: -5)))
                    .font(.custom("Roboto-Regular", size: 14))
                    .tracking(0.56)
                    .frame(maxWidth: .infinity, alignment:.topLeading)
            }
            .padding([.horizontal],20)
            .padding([.top],3)
            .frame(width:320,height: 43)
            
            Rectangle()
                .fill(Color("gray-100"))
                .frame(width: 320, height: 1)
            
            VStack(spacing:0){
                ForEach(data.items.indices, id: \.self)  { index in
                    TransportItemView(data: data.items[index])
                    
                    if index != data.items.count-1 {
                        Rectangle()
                            .fill(Color("gray-100"))
                            .frame(width:320, height: 1)
                    }
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 10).fill(Color.white)
        )
    }
}

struct ETicketView: View {
    @EnvironmentObject var eTicketListVM: ETicketListViewModel
    @State var list: [TransportList] = []
    @Binding var selectedIndex: Int
    let months: [MonthSelection]
    
    var body: some View {
        ScrollView(showsIndicators:false){
            MonthSelector(months: months, selectedIndex: $selectedIndex)
            
            VStack(spacing:20){
                ForEach(list.indices, id: \.self)  { index in
                    ETicketItemView(data: list[index])
                }
            }
            .frame(width: 320)
            .padding(.bottom,80)
        }
        .onAppear {
            list = eTicketListVM.GetList(year: months[selectedIndex].year, startMonth: months[selectedIndex].month, endMonth: months[selectedIndex].month+1)
        }
        .onChange(of: selectedIndex, perform: { newValue in
            list = eTicketListVM.GetList(year: months[newValue].year, startMonth: months[newValue].month, endMonth: months[newValue].month+1)
        })
    }
}

struct ETicketView_Previews: PreviewProvider {
    static var leafVM:LeafViewModel = LeafViewModel()
    static var badgeVM:BadgeViewModel = BadgeViewModel()
    static var eTicketListVM:ETicketListViewModel = ETicketListViewModel(leafVM: leafVM, badgeVM: badgeVM)
    @State static var selectedIndex: Int = 0
    static let months: [MonthSelection] = [
        MonthSelection(year: 2022, month: 5),
        MonthSelection(year: 2022, month: 3),
    ]
    
    static var previews: some View {
        ETicketView(selectedIndex: $selectedIndex,months: months)
            .environmentObject(eTicketListVM)
    }
}
