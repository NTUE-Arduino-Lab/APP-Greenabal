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
    static let background = BackgroundViewModel()
    
    static var previews: some View {
        ContentView().environmentObject(background)
    }
}