//
//  GreenabalApp.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

@main
struct GreenabalApp: App {
    @StateObject private var background = BackgroundViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabBar()
                .environmentObject(background)
        }
    }
}
