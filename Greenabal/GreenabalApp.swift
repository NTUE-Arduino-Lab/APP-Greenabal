//
//  GreenabalApp.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

@main
struct GreenabalApp: App {
    @StateObject private var backgroundViewModel = BackgroundViewModel()
    @StateObject private var leafViewModel:LeafViewModel = LeafViewModel()
    @StateObject private var budgeViewModel:BudgeViewModel = BudgeViewModel()
    @StateObject private var taskListViewModel:TaskListViewModel = TaskListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(backgroundViewModel)
                .environmentObject(leafViewModel)
                .environmentObject(budgeViewModel)
                .environmentObject(taskListViewModel)
        }
    }
}
