//
//  ActionView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/8.
//

import SwiftUI

struct ActionView: View {
    @EnvironmentObject var background: BackgroundViewModel
    private let title = "環保行動"
    private let name = "Action"
    
    var body: some View {
        ZStack(alignment: .top){
            Header(title: title, name: name)
        
            VStack{
                Text("ActionView")
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .center)
        }
        .background(background.color)
        .clipped()
    }
}

struct ActionView_Previews: PreviewProvider {
    static let background = BackgroundViewModel()
    
    static var previews: some View {
        TabBar().environmentObject(background)
    }
}
