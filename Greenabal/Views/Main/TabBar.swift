//
//  TabBar.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

struct TabBar: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex){
            SettingView()
                .onTapGesture {
                    self.selectedIndex = 4
                }
                .tabItem{
                    Image("icon_setting")
                }.tag(1)
            TaskView()
                .onTapGesture {
                    self.selectedIndex = 1
                }
                .tabItem{
                    Image("icon_action")
                }.tag(1)
            HomeView()
                .onTapGesture {
                    self.selectedIndex = 0
                }
                .tabItem{
                    Image("icon_home")
                }.tag(0)
            TaskView()
                .onTapGesture {
                    self.selectedIndex = 2
                }
                .tabItem{
                    Image("icon_task")
                }.tag(2)
            AchivementView()
                .onTapGesture {
                    self.selectedIndex = 3
                }
                .tabItem{
                    Image("icon_achivement")
                }.tag(3)
            
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
