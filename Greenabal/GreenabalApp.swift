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
    @StateObject private var badgeViewModel:BadgeViewModel
    @StateObject private var taskListViewModel:TaskListViewModel = TaskListViewModel()
    @StateObject private var eTicketListViewModel:ETicketListViewModel
    @StateObject private var barcodeListViewModel:BarcodeListViewModel
    
    init(){
        let lvm = LeafViewModel()
        let bvm = BadgeViewModel()
        _leafViewModel = StateObject(wrappedValue: lvm)
        _badgeViewModel = StateObject(wrappedValue: bvm)
        _barcodeListViewModel = StateObject(wrappedValue: BarcodeListViewModel(leafViewModel: lvm, badgeViewModel: bvm))
        _eTicketListViewModel = StateObject(wrappedValue: ETicketListViewModel(leafViewModel: lvm, badgeViewModel: bvm))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(backgroundViewModel)
                .environmentObject(leafViewModel)
                .environmentObject(badgeViewModel)
                .environmentObject(taskListViewModel)
                .environmentObject(eTicketListViewModel)
                .environmentObject(barcodeListViewModel)
        }
    }
}
