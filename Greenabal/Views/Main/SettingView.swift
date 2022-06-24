//
//  SettingView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

struct SettingBtn {
    let title: String
    let info: String
}

struct SettingView: View {
    @State private var title = "設定"
    private let name = "Setting"
    let btns:[SettingBtn] = [
        SettingBtn(title: "個人資訊",info: ""),
        SettingBtn(title: "電子載具",info: "/SWT9A4E"),
        SettingBtn(title: "電子票證管理",info: "已綁定 1 張"),
        SettingBtn(title: "客戶服務",info: ""),
        SettingBtn(title: "使用條款",info: ""),
    ]
    
    var body: some View {
        VStack{
            Header(title: $title, name: name)
            
            VStack(spacing: 20){
                ForEach(btns.indices, id: \.self)  { index in
                    Button(action: {
                        
                    }, label: {
                        HStack(spacing: 10){
                            Text("\(btns[index].title)")
                                .font(.custom("Roboto Medium", size: 14))
                                .foregroundColor(Color(red: 0.12, green: 0.12, blue: 0.12, opacity: 1))
                                .tracking(0.56)
                            Text("\(btns[index].info)")
                                .font(.custom("Roboto Medium", size: 12))
                                .foregroundColor(Color(red: 0.65, green: 0.65, blue: 0.65, opacity: 1))
                                .tracking(0.48)
                            Spacer()
                            Image("icon_arrow")
                        }
                    })
                    .frame(width: 320,
                           height: 48,
                           alignment: .center)
                    .padding(.horizontal,16)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: Color(#colorLiteral(red: 0.7572221755981445, green: 0.903833270072937, blue: 0.966666579246521, alpha: 0.25)), radius:4, x:0, y:4)
                    )
                }
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .top)
            .padding(.top,20)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(initSelectedTab: "Setting")
    }
}
