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
//        .background(LinearGradient(
//                gradient: Gradient(stops: [
//                    .init(color: Color(#colorLiteral(red: 0.6102343797683716, green: 0.7855484485626221, blue: 0.9125000238418579, alpha: 1)), location: 0),
//                    .init(color: Color(#colorLiteral(red: 0.915928840637207, green: 0.9526067972183228, blue: 0.9791666865348816, alpha: 1)), location: 1)]),
//                startPoint: UnitPoint(x: 0.5, y: -3.0616171314629196e-17),
//                endPoint: UnitPoint(x: 0.5, y: 0.9999999999999999)))
        .foregroundColor(.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static let leafViewModel = LeafViewModel()
    
    static var previews: some View {
        TabBar()
            .environmentObject(leafViewModel)
    }
}
