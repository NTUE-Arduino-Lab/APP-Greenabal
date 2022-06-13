//
//  SubTabBar.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/10.
//

import SwiftUI

struct SubTabBar: View {
    let tabs: [String]
    @Binding var tabTarget: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            ForEach(Array(tabs.enumerated()), id: \.element){ index, tab in
                Button(action: {
                    withAnimation {
                        tabTarget = (tabTarget == 0 ? 1 : 0)
                    }
                }, label: {
                    Text(tab)
                        .foregroundColor(Color.black)
                        .font(.custom("Roboto Medium", size: 16))
                        .tracking(0.64)
                })
                .buttonStyle(.borderless)
                .frame(width: 142, height: 36)
                .background(RoundedRectangle(cornerRadius: 43))
                .foregroundColor(tabTarget == index ? Color.white : Color("bg-gray"))
                .font(.system(size:16, weight: .medium))
                .shadow(color: tabTarget == index ? Color(#colorLiteral(red: 0.6958333253860474, green: 0.6958333253860474, blue: 0.6958333253860474, alpha: 0.25)):Color.clear, radius:4, x:0, y:4 )
            }
        }
        .background(RoundedRectangle(cornerRadius: 43).fill(Color("bg-gray")))
        .frame(width: 290, height: 42)
        .cornerRadius(.infinity)
        .shadow(color: Color(#colorLiteral(red: 0.7372549176216125, green: 0.7372549176216125, blue: 0.7372549176216125, alpha: 0.25)), radius:4, x:0, y:0)
        .padding(12)
    }
}

struct SubTabBar_Previews: PreviewProvider {
    @State static var tabTarget = 0
    
    static var previews: some View {
        SubTabBar(tabs:["手機載具","電子票證"],tabTarget:$tabTarget)
    }
}
