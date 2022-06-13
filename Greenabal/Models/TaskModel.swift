//
//  TaskModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/14.
//
import Foundation

struct Task{
    //    任務
    let task: TaskData
    var isComplete: Bool
    
    init(task: TaskData, isComplete: Bool = false){
        self.task = task
        self.isComplete = isComplete
    }
    
    mutating func updateCompletion(){
        self.isComplete = !self.isComplete
    }
}

enum TaskType {
case normal
case knowledge
}

struct TaskData{
    //    任務
    let name: String
    var leaf: Int
    let type: TaskType
    let bagdge: String
}

extension TaskData {
    static let all: [TaskData] = [
        TaskData(name: "閱讀環保知識", leaf: 2, type: .knowledge, bagdge: "知識小達人"),
        TaskData(name: "自備環保餐具無拿取免洗餐具", leaf: 3, type: .normal, bagdge: "環保小達人"),
        TaskData(name: "落實資源回收", leaf: 2, type: .normal, bagdge: "環保小達人"),
        TaskData(name: "自備購物袋", leaf: 2, type: .normal, bagdge: "環保小達人"),
        TaskData(name: "檢查並拔掉無使用的插頭", leaf: 2, type: .normal, bagdge: "省電小達人"),
    ]
}

