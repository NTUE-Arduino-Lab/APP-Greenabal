//
//  KnowledgeModalView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/26.
//

import SwiftUI

struct KnowledgeModalContent: View {
    @EnvironmentObject var modalVM: ModalViewModel
    @EnvironmentObject var taskListVM: TaskListViewModel
    @State var btnDisabled: Bool = false
    let content: String
    
    var body: some View {
        VStack{
            ScrollView{
                Text(content)
                    .font(.custom("Roboto Medium", size: 14))
                    .tracking(0.56)
                    .lineSpacing(6)
            }
            .frame(height: 253)
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
        .padding(.horizontal,24)
        .frame(width: 300)
        
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(red: 241/255, green: 241/255, blue: 241/255))
            .frame(width: 300,height: 1)
        
        ModalButton(text: "\(modalVM.taskData.task.leaf)", icon: !btnDisabled ?  "icon_leaf_green" : "icon-leaf-gray-2", action: btnAction, disabled: $btnDisabled)
    }
    
    func btnAction(){
        taskListVM.completeTask(index: 0)
        btnDisabled = true
    }
}

struct KnowledgeModalContent_Previews: PreviewProvider {
    
    static var previews: some View {
        KnowledgeModalContent(content: "aa")
    }
}
