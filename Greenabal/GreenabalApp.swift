//
//  GreenabalApp.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

@main
struct GreenabalApp: App {
    @StateObject private var backgroundVM = BackgroundViewModel()
    @StateObject private var modalVM: ModalViewModel
    @StateObject private var leafVM:LeafViewModel
    @StateObject private var badgeVM:BadgeViewModel
    @StateObject private var taskListVM:TaskListViewModel
    @StateObject private var eTicketListVM:ETicketListViewModel
    @StateObject private var barcodeListVM:BarcodeListViewModel
    @StateObject private var islandVM: IslandViewModel
    
    init(){
        let lvm = LeafViewModel()
        let mvm = ModalViewModel()
        let bvm = BadgeViewModel(leafVM: lvm,modalVM: mvm)
        _leafVM = StateObject(wrappedValue: lvm)
        _badgeVM = StateObject(wrappedValue: bvm)
        _modalVM = StateObject(wrappedValue: mvm)
        _taskListVM = StateObject(wrappedValue: TaskListViewModel(leafVM: lvm, badgeVM: bvm))
        _barcodeListVM = StateObject(wrappedValue: BarcodeListViewModel(leafVM: lvm, badgeVM: bvm))
        _eTicketListVM = StateObject(wrappedValue: ETicketListViewModel(leafVM: lvm, badgeVM: bvm))
        _islandVM =  StateObject(wrappedValue: IslandViewModel(leafVM: lvm))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(backgroundVM)
                .environmentObject(leafVM)
                .environmentObject(badgeVM)
                .environmentObject(taskListVM)
                .environmentObject(eTicketListVM)
                .environmentObject(barcodeListVM)
                .environmentObject(islandVM)
                .environmentObject(modalVM)
                .onAppear(){
//                    eTicketListVM.AddItem(date: "2022/06/22", title: "youbike hihi", time: "20:22", leaf: 4, badge: BadgeType.youbike.rawValue)
                }
        }
    }
}
