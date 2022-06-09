//
//  HomeView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var background: BackgroundViewModel
    private let title = "No.168 初來乍島 Lv.3"
    private let name = "Home"
    
    var body: some View {
        VStack{
            Header(title: title, name: name)
        
            VStack{
                Text("HomeView")
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .center)
        }
        .background(background.color)
        .foregroundColor(.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static let background = BackgroundViewModel()
    
    static var previews: some View {
        TabBar().environmentObject(background)
    }
}
