//
//  TabBarViewModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/9.
//

import Foundation

struct Tab: Identifiable{
    let id = UUID()
    let name: String
    let image: String
    let selectedImage: String
    let title: String
}

extension Tab {
    static let all: [Tab] = [
        Tab(name: "Setting", image: "icon_setting", selectedImage: "icon_setting_active",title: "設定"),
        Tab(name: "Action", image: "icon_action", selectedImage: "icon_action_active",title: "環保行動"),
        Tab(name: "Home", image: "icon_home", selectedImage: "icon_home_active",title: "首頁"),
        Tab(name: "Task", image: "icon_task", selectedImage: "icon_task_active",title: "每日任務"),
        Tab(name: "Achivement", image: "icon_achivement", selectedImage: "icon_achivement_active",title: "成就")
    ]
}
