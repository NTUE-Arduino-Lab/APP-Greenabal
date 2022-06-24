//
//  TaskListViewModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/13.
//

import Foundation

class TaskListViewModel: ObservableObject{
    @Published var taskList: [Task]
    @Published var completeCount: Int
    let leafVM: LeafViewModel
    let badgeVM: BadgeViewModel
    
    init(leafVM: LeafViewModel,badgeVM: BadgeViewModel){
        self.leafVM = leafVM
        self.badgeVM = badgeVM
        
        var testList:[Task] = []
        TaskData.all.forEach { item in
            testList.append(Task(task: item))
        }
        
        self.taskList = testList
        self.completeCount = 0
        
        print("--------------tasklist init-----------------")
        print(taskList)
    }
    
    func completeTask(index: Int){
        //        完成任務
        if !taskList[index].isComplete{
            taskList[index].updateCompletion()
            completeCount+=1
            
            print("--------------complete task-----------------")
            print(taskList)
            
            leafVM.AddCount(num: taskList[index].task.leaf, record: true)
            badgeVM.RefreshBadge(name: taskList[index].task.bagdge)
        }
    }
    
    func refreshTask(index: Int){
        //        刷新
        taskList[index] = Task(task:TaskData.all[index])
        
        print("--------------refresh task-----------------")
        print(taskList)
    }
    
    func updateList(){
        //        每天更新List
    }
}
