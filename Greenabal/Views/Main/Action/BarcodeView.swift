//
//  BarcodeView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/12.
//

import SwiftUI

struct BuyItem: View {
    
    var body: some View {
        HStack(alignment: .center, spacing: 14){
            Text("蒲公英環保抽取衛...")
                .font(.custom("Roboto-Regular", size: 14))
                .tracking(0.56)
                .frame(maxWidth: .infinity, alignment:.leading)
            
            Text("環保標章")
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

struct BarcodeItem: View {
    
    var body: some View {
        VStack(alignment:.leading, spacing: 0){
            HStack(alignment:.center, spacing: 16){
                Image("icon_barcode")
                Text("全聯實業")
                    .font(.custom("Roboto-Regular", size: 14))
                    .tracking(0.56)
                    .frame(maxWidth: .infinity, alignment:.topLeading)
                Text("5/19")
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
                BuyItem()
                
                Rectangle()
                    .fill(Color("gray-100"))
                    .frame(width:320, height: 1)
                
                BuyItem()
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 10).fill(Color.white)
        )
    }
}

struct BarcodeView: View {
    
    var body: some View {
        ScrollView(showsIndicators:false){
            MonthSelector()
            
            VStack(spacing:20){
                BarcodeItem()
                BarcodeItem()
                BarcodeItem()
                BarcodeItem()
                BarcodeItem()
                BarcodeItem()
            }
            .frame(width: 320)
            .padding(.bottom,80)
        }
    }
}

struct BarcodeView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeView()
    }
}
