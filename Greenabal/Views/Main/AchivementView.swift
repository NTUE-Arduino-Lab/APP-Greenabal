//
//  AchivementView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/8.
//

import SwiftUI

struct AchivementView: View {
    @EnvironmentObject var background: BackgroundViewModel
    private let title = "成就"
    private let name = "Achivement"

    var body: some View {
        VStack{
            Header(title: title, name: name)
        
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
