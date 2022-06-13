//
//  AchivementView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/8.
//

import SwiftUI

struct AchivementView: View {
    @EnvironmentObject var backgroundViewModel: BackgroundViewModel
    @EnvironmentObject var leafViewModel: LeafViewModel
    @EnvironmentObject var budgeViewModel: BudgeViewModel
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
        .background(backgroundViewModel.color)
    }
}

struct AchivementView_Previews: PreviewProvider {
    static let backgroundViewModel = BackgroundViewModel()
    static let leafViewModel = LeafViewModel()
    static let budgeViewModel = BudgeViewModel()
    
    static var previews: some View {
        TabBar(initSelectedTab: "Achivement").environmentObject(backgroundViewModel).environmentObject(leafViewModel).environmentObject(budgeViewModel)
    }
}
