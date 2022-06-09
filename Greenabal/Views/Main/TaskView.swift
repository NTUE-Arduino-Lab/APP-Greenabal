//
//  TaskView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var background: BackgroundViewModel
    
    var body: some View {
        ZStack{
            VStack{
                Text("TaskView")
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .center)
        }
        .background(background.color)
    }
}

struct TaskView_Previews: PreviewProvider {
    static let background = BackgroundViewModel()
    
    static var previews: some View {
        TabBar().environmentObject(background)
    }
}

