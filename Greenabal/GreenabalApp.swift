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
    @StateObject private var eTicketListViewModel:ETicketListViewModel = ETicketListViewModel()
    @StateObject private var barcodeListViewModel:BarcodeListViewModel = BarcodeListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(backgroundViewModel)
                .environmentObject(leafViewModel)
                .environmentObject(budgeViewModel)
                .environmentObject(taskListViewModel)
                .environmentObject(eTicketListViewModel)
                .environmentObject(barcodeListViewModel)
        }
    }
}
