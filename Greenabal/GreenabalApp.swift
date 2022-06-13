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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(backgroundViewModel)
                .environmentObject(leafViewModel)
        }
    }
}
