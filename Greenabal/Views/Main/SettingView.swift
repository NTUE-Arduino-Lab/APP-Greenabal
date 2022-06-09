//
//  SettingView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var background: BackgroundViewModel
    
    var body: some View {
        ZStack{
            VStack{
                Text("SettingView")
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .center)
        }
        .background(background.color)
    }
}

struct SettingView_Previews: PreviewProvider {
    static let background = BackgroundViewModel()
    
    static var previews: some View {
        TabBar().environmentObject(background)
    }
}
