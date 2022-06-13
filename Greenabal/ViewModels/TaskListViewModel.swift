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
    
    init(){
        var testList:[Task] = []
        TaskData.all.forEach { item in
            testList.append(Task(task: item))
        }
        
        self.taskList = testList
        self.completeCount = 0
    }
    
    func completeTask(index: Int){
        //        完成任務
        taskList[index].updateCompletion()
        completeCount+=1
    }
    
    func refreshTask(index: Int){
        //        刷新
        taskList[index] = Task(task:TaskData.all[index])
    }
    
    func updateList(){
        //        每天更新List
    }
}
