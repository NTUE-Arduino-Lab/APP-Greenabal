//
//  HomeView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var backgroundViewModel: BackgroundViewModel
    @EnvironmentObject var leafViewModel: LeafViewModel
    private let title = "No.168 初來乍島 Lv.3"
    private let name = "Home"
    
    var body: some View {
        VStack{
            Header(title: title, name: name)
        
            VStack{
                Text("HomeView")
                Text("leaf \(leafViewModel.count)")
                Text("autoleaf \(leafViewModel.autoIncreseCount)/hr")
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .center)
        }
        .background(backgroundViewModel.color)
        .foregroundColor(.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static let backgroundViewModel = BackgroundViewModel()
    static let leafViewModel = LeafViewModel()
    
    static var previews: some View {
        TabBar()
            .environmentObject(leafViewModel)
            .environmentObject(backgroundViewModel)
    }
}
