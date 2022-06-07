//
//  TaskItem.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

struct TaskItem: View {
    var task: Task
    var body: some View {
        Text("TaskItem")
    }
}

struct TaskItem_Previews: PreviewProvider {
    static var previews: some View {
        TaskItem(task: taskList[0])
    }
}
