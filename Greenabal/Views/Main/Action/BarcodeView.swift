//
//  BarcodeView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/12.
//

import SwiftUI

struct BuyItemView: View {
    let data: BuyItem
    
    var body: some View {
        HStack(alignment: .center, spacing: 14){
            Text(data.name.prefix(8))
                .font(.custom("Roboto-Regular", size: 14))
                .tracking(0.56)
                .frame(maxWidth: .infinity, alignment:.leading)
            
            Text(data.seal)
                .font(.custom("Roboto-Regular", size: 12))
                .tracking(0.48)
                .foregroundColor(Color("green-font"))
                .padding([.horizontal],8)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("green-font"), style: StrokeStyle(lineWidth: 1.5))
                        .frame(height:21)
                )
            
            Image("icon_gift")
        }
        .padding([.leading],15)
        .padding([.trailing],20)
        .frame(height: 50)
    }
}

struct BarcodeItemView: View {
    let data: BuyList
    
    var body: some View {
        VStack(alignment:.leading, spacing: 0){
            HStack(alignment:.center, spacing: 16){
                Image("icon_barcode")
                Text(data.shop)
                    .font(.custom("Roboto-Regular", size: 14))
                    .tracking(0.56)
                    .frame(maxWidth: .infinity, alignment:.topLeading)
                Text(data.date.suffix(from: data.date.index(data.date.endIndex, offsetBy: -5)))
                    .font(.custom("Roboto-Regular", size: 14))
                    .tracking(0.56)
            }
            .padding([.horizontal],20)
            .padding([.top],3)
            .frame(width:320,height: 43)
            
            Rectangle()
                .fill(Color("gray-100"))
                .frame(width: 320, height: 1)
            
            VStack(spacing:0){
                ForEach(data.items.indices, id: \.self)  { index in
                    BuyItemView(data: data.items[index])
                    
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

struct BarcodeView: View {
    @EnvironmentObject var barcodeListVM: BarcodeListViewModel
    @State var list: [BuyList] = []
    
    var body: some View {
        ScrollView(showsIndicators:false){
            MonthSelector()
            
            VStack(spacing:20){
                ForEach(list.indices, id: \.self)  { index in
                    BarcodeItemView(data: list[index])
                }
            }
            .frame(width: 320)
            .padding(.bottom,80)
        }
        .onAppear {
            list = barcodeListVM.GetList(year: 2022, startMonth: 5, endMonth: 6)
        }
    }
}

struct BarcodeView_Previews: PreviewProvider {
    static var leafVM:LeafViewModel = LeafViewModel()
    static var badgeVM:BadgeViewModel = BadgeViewModel()
    static var barcodeListVM:BarcodeListViewModel = BarcodeListViewModel(leafVM: leafVM, badgeVM: badgeVM)
    
    static var previews: some View {
        BarcodeView()
            .environmentObject(barcodeListVM)
    }
}
