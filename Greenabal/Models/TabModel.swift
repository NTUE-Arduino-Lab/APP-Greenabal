//
//  TabBarViewModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/9.
//

import Foundation

struct Tab: Identifiable{
    var id = UUID()
    var name: String
    var image: String
    var selectedImage: String
}

extension Tab {
    static let all: [Tab] = [
        Tab(name: "Setting", image: "icon_setting", selectedImage: "icon_setting_active"),
        Tab(name: "Action", image: "icon_action", selectedImage: "icon_action_active"),
        Tab(name: "Home", image: "icon_home", selectedImage: "icon_home_active"),
        Tab(name: "Task", image: "icon_task", selectedImage: "icon_task_active"),
        Tab(name: "Achivement", image: "icon_achivement", selectedImage: "icon_achivement_active")
    ]
}
