//
//  ContentView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabBar()
    }
}

struct ContentView_Previews: PreviewProvider {
    static let backgroundViewModel = BackgroundViewModel()
    static let leafViewModel = LeafViewModel()
    
    static var previews: some View {
        ContentView()
            .environmentObject(backgroundViewModel).environmentObject(leafViewModel)
    }
}
