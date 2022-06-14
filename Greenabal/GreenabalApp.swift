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
    @StateObject private var leafViewModel:LeafViewModel
    @StateObject private var budgeViewModel:BudgeViewModel
    @StateObject private var taskListViewModel:TaskListViewModel = TaskListViewModel()
    @StateObject private var eTicketListViewModel:ETicketListViewModel = ETicketListViewModel()
    @StateObject private var barcodeListViewModel:BarcodeListViewModel
    
    init(){
        let lvm = LeafViewModel()
        let bvm = BudgeViewModel()
        _leafViewModel = StateObject(wrappedValue: lvm)
        _budgeViewModel = StateObject(wrappedValue: bvm)
        _barcodeListViewModel = StateObject(wrappedValue: BarcodeListViewModel(leafViewModel: lvm, budgeViewModel: bvm))
    }
    
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
