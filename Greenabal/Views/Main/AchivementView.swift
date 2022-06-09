//
//  AchivementView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/8.
//

import SwiftUI

struct AchivementView: View {
    @EnvironmentObject var background: BackgroundViewModel
    
    var body: some View {
        ZStack{
            VStack{
                Text("AchivementView")
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .center)
        }
        .background(background.color)
    }
}

struct AchivementView_Previews: PreviewProvider {
    static let background = BackgroundViewModel()
    
    static var previews: some View {
        TabBar().environmentObject(background)
    }
}
