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
    @EnvironmentObject var badgeViewModel: BadgeViewModel
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
//        .background(LinearGradient(
//            gradient: Gradient(stops: [
//                .init(color: Color(#colorLiteral(red: 0.6102343797683716, green: 0.7855484485626221, blue: 0.9125000238418579, alpha: 1)), location: 0),
//                .init(color: Color(#colorLiteral(red: 0.915928840637207, green: 0.9526067972183228, blue: 0.9791666865348816, alpha: 1)), location: 1)]),
//            startPoint: UnitPoint(x: 0.5, y: -3.0616171314629196e-17),
//            endPoint: UnitPoint(x: 0.5, y: 0.9999999999999999))
//        )
    }
}

struct AchivementView_Previews: PreviewProvider {
    static let leafViewModel = LeafViewModel()
    static let badgeViewModel = BadgeViewModel()
    
    static var previews: some View {
        TabBar(initSelectedTab: "Achivement").environmentObject(leafViewModel).environmentObject(badgeViewModel)
    }
}
