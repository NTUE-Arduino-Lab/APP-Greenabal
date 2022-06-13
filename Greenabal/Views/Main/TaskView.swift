//
//  TaskView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var background: BackgroundViewModel
    private let title = "每日任務"
    private let name = "Task"

    var body: some View {
        VStack{
            Header(title: title, name: name)
        
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
    static let backgroundViewModel = BackgroundViewModel()
    
    static var previews: some View {
        TabBar(initSelectedTab: "Task").environmentObject(backgroundViewModel)
    }
}

