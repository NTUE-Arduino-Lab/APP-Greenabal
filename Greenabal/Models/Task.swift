//
//  Task.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import Foundation

struct Task: Identifiable{
    var id = UUID()
    
    var name: String
    var checked:Bool
    var leaf: Int
}

var taskList = [
    Task(name:"閱讀環保知識",checked:false,leaf: 2),
    Task(name:"自備環保餐具無拿取免洗餐具",checked:false,leaf: 3),
    Task(name:"落實資源回收",checked:false,leaf: 2),
    Task(name:"自備購物袋/塑膠袋",checked:false,leaf: 3),
    Task(name:"檢查並拔掉無使用的插頭",checked:false,leaf: 2),
]
