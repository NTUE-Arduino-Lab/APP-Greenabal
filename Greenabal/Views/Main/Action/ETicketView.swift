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
    @EnvironmentObject var eTicketListViewModel: ETicketListViewModel
    @State var list: [TransportList] = []
    
    var body: some View {
        ScrollView(showsIndicators:false){
            MonthSelector()
            
            VStack(spacing:20){
                ForEach(list.indices, id: \.self)  { index in
                    ETicketItemView(data: list[index])
                }
            }
            .frame(width: 320)
            .padding(.bottom,80)
            
            HStack(spacing: 20){
                Button(action: {
                    eTicketListViewModel.AddItem(date: "2022/05/18", title: "youbike hihi", time: "20:22", leaf: 4, badge: BadgeType.youbike.rawValue)
                }, label: {
                    Text("Add Same Date ETicket")
                })
                
                Button(action: {
                    eTicketListViewModel.AddItem(date: "2022/06/22", title: "youbike hihi", time: "20:22", leaf: 4, badge: BadgeType.youbike.rawValue)
                }, label: {
                    Text("Add New Date ETicket")
                })
            }
        }
        .onAppear {
            list = eTicketListViewModel.GetList(year: 2022, startMonth: 5, endMonth: 6)
        }
    }
}

struct ETicketView_Previews: PreviewProvider {
    static var leafViewModel:LeafViewModel = LeafViewModel()
    static var badgeViewModel:BadgeViewModel = BadgeViewModel()
    static var eTicketListViewModel:ETicketListViewModel = ETicketListViewModel(leafViewModel: leafViewModel, badgeViewModel: badgeViewModel)
    
    static var previews: some View {
        ETicketView()
            .environmentObject(eTicketListViewModel)
    }
}
