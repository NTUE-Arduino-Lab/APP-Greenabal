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
    @Binding var selectedIndex: Int
    let months: [MonthSelection]
    
    var body: some View {
        ScrollView(showsIndicators:false){
            MonthSelector(months: months, selectedIndex: $selectedIndex)
            
            VStack(spacing:20){
                ForEach(list.indices, id: \.self)  { index in
                    BarcodeItemView(data: list[index])
                }
            }
            .frame(width: 320)
            .padding(.bottom,80)
        }
        .onAppear {
            list = barcodeListVM.GetList(year: months[selectedIndex].year, startMonth: months[selectedIndex].month, endMonth: months[selectedIndex].month+1)
        }
        .onChange(of: selectedIndex, perform: { newValue in
            list = barcodeListVM.GetList(year: months[newValue].year, startMonth: months[newValue].month, endMonth: months[newValue].month+1)
        })
    }
}

struct BarcodeView_Previews: PreviewProvider {
    static var leafVM:LeafViewModel = LeafViewModel()
    static var badgeVM:BadgeViewModel = BadgeViewModel()
    static var barcodeListVM:BarcodeListViewModel = BarcodeListViewModel(leafVM: leafVM, badgeVM: badgeVM)
    @State static var selectedIndex: Int = 0
    static let months: [MonthSelection] = [
        MonthSelection(year: 2022, month: 5),
        MonthSelection(year: 2022, month: 3),
    ]
    
    
    static var previews: some View {
        BarcodeView(selectedIndex: $selectedIndex,months: months)
            .environmentObject(barcodeListVM)
    }
}
